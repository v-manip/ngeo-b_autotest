#!/usr/bin/python

import sys

def main(args):
    if len(args) != 2:
        raise Exception("Usage: %s <input-csv> <out-requests>" % sys.argv[0])
    
    print "Processing input file %s." % args[0]
    
    out_requests = args[1]
    
    with open(args[0]) as in_csv, open(out_requests, "w+") as out_file:
        for line in in_csv:
            values = line.split("|")
            if len(values) == 1:
                time = line[:-1]
            else:
                z = int(values[0])
                y = 2**int(values[0]) - int(values[1]) -1
                x = int(values[2])
                out_file.write("\"/c/wmts/?SERVICE=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=MSI_IMG_3A&STYLE=default&TILEMATRIXSET=WGS84&FORMAT=image/png&TileMatrix=%s&TileRow=%s&TileCol=%s&time=%s\"\n" % (z, y, x, time))
    
    print "Finished."

if __name__ == "__main__":
    main(sys.argv[1:])
