
import csv
import sys
from gsc_to_browse_report import handle_file
from os.path import join, basename

def main(args):
    if len(args) != 3:
        raise Exception("Usage: %s <input-csv> <out-dir> <out-jmeter-csv>")

    out_dir = args[1]
    out_jmeter_csv = args[2]

    count_success = 0
    count_failure = 0
        

    with open(args[0]) as in_csv, open(out_jmeter_csv, "w+") as jmeter_file:
        csv_reader = csv.reader(in_csv)
        for xml_filename, image_filename in csv_reader:
            print "Working on %s" % xml_filename
            try:
                browsereport = join(out_dir, basename(xml_filename))
                handle_file(xml_filename, basename(image_filename), browsereport, False)
                jmeter_file.write(basename(xml_filename) + "\n")
            except Exception, e:
                print "Error: %s" % str(e)
                count_failure += 1
            else:
                count_success += 1

    print "Finished. Sucesses: %d, Failures: %d Rate: %f" % (count_success, count_failure, float(count_success) / (float(count_success  + count_failure)))
                

if __name__ == "__main__":
    main(sys.argv[1:])
