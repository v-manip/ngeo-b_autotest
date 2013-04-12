import sys
from os.path import splitext

from argparse import ArgumentParser
from lxml import etree
from lxml.builder import ElementMaker
from eoxserver.core.util.timetools import getDateTime
from eoxserver.contrib import gdal, osr

from ngeo_browse_server.parsing import XMLParser
from ngeo_browse_server.config.browsereport.data import (
    BrowseReport, ModelInGeotiffBrowse
)
from ngeo_browse_server.config.browsereport.serialization import (
    serialize_browse_report
)


# XML schema and namespace declarations
gsc_nsmap = dict(
    gsc="http://earth.esa.int/gsc", opt="http://earth.esa.int/opt",
    eop="http://earth.esa.int/eop", xlink="http://www.w3.org/1999/xlink",
    xsi="http://www.w3.org/2001/XMLSchema-instance",
    gml="http://www.opengis.net/gml"
)

gsc_browse_decoder = XMLParser({
    #"browse_identifier": ("gsc:opt_metadata/gml:metaDataProperty/gsc:EarthObservationMetaData/eop:identifier/text()", multiplicity="?"),
    "browse_identifier": ("gsc:orderReference/text()", str, "?"),
    "start_time": ("gsc:opt_metadata/gml:validTime/gml:TimePeriod/gml:beginPosition/text()", getDateTime),
    "end_time": ("gsc:opt_metadata/gml:validTime/gml:TimePeriod/gml:endPosition/text()", getDateTime),
    "reference_system_identifier": "gsc:opt_metadata/gml:target/eop:Footprint/gml:multiExtentOf/gml:MultiSurface/@srsName"
}, gsc_nsmap)

gsc_report_decoder = XMLParser({
    "responsible_org_name": "gsc:responsibleOrgName/text()",
    "date_time": ("gsc:dateTime/text()", getDateTime),
    "browse_type": "gsc:opt_metadata/gml:metaDataProperty/gsc:EarthObservationMetaData/eop:productType/text()",
    "browses": (".", gsc_browse_decoder, "+")
}, gsc_nsmap)

EXT_TO_IMAGE_TYPE = {
    ".jpg": "Jpeg",
    ".jpeg": "Jpeg",
    ".jp2": "Jpeg2000",
    ".tif": "TIFF",
    ".tiff": "TIFF",
    ".png": "PNG",
    ".bmp": "BMP"
}


def main(args):
    # setup argument parser
    parser = ArgumentParser()
    parser.add_argument("--pretty-print", "-p", dest="pretty_print",
                        action="store_true", default=False)
    parser.add_argument("input_xml", nargs=1, help="The input GSC file.")
    parser.add_argument("input_image", nargs=1, help="The input browse image.")
    parser.add_argument("output", nargs=1, help="The output XML file.")
    
    parsed_args = parser.parse_args(args)

    # get arguments
    pretty_print = parsed_args.pretty_print
    xml_filename = parsed_args.input_xml[0]
    image_filename = parsed_args.input_image[0]
    output_filename = parsed_args.output[0]

    handle_file(xml_filename, image_filename, output_filename, pretty_print)


def handle_file(xml_filename, image_filename, output_filename, pretty_print):
    # parse and decode input GSC file
    doc = etree.parse(xml_filename)
    decoded = gsc_report_decoder(doc)

    # prepare and initialize browse report and browse
    def _prepare_browse(decoded_browse):
        _, ext = splitext(image_filename)
        decoded_browse["image_type"] = EXT_TO_IMAGE_TYPE[ext]
        decoded_browse["file_name"] = image_filename
        
        return ModelInGeotiffBrowse(**decoded_browse)
    
    decoded["browses"] = map(_prepare_browse, decoded["browses"])

    browse_report = BrowseReport(**decoded)

    # serialize the report to the file
    with open(output_filename, "w+") as f:
        serialize_browse_report(browse_report, f, pretty_print=pretty_print)
    

if __name__ == "__main__":
    main(sys.argv[1:])
