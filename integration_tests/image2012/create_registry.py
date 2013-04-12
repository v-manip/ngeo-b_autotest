import sys
import os
from os.path import abspath, splitext, exists, join
import csv


def browse_filename(base, prefix="_brs", ext=".tif"):
    return "".join((base, prefix, ext))


def main(args):
    if len(args) != 2:
        raise Exception("Usage: %s <input-tree-root> <registry-csv>" % __file__)

    tree_root = args[0]
    output_filename = args[1]

    with open(output_filename, "w+") as csvfile:
        csvwriter = csv.writer(csvfile)

        for path, _, files in os.walk(tree_root):
            for filename in files:
                base, ext = splitext(filename)
                if ext == ".xml":
                    for browse_ext in (".jpg", ".tif"):
                        browse_filename = join(path, base + "_brs" + browse_ext)
                        if exists(join(path, base + "_brs" + browse_ext)):
                            csvwriter.writerow((join(path, filename), browse_filename))
            
    

if __name__ == "__main__":
    main(sys.argv[1:])
