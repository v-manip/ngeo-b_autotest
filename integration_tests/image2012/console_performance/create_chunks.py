import csv
import argparse
import time
import os
from time import gmtime, strptime, strftime
from xml.dom.minidom import parse, parseString


#argument specification for script
parser = argparse.ArgumentParser(description='Script which allows to create a csv which separates browse reports in equaly sized chunks of times')

parser.add_argument('--create', nargs=2,
                   help='Pass arguments with path to browse reports, browsecount and output csv filepath')

parser.add_argument('chunks', default=50, type=int,
                   help='an integer for the chunk size')


def createChunks(browsePath, output, browsecount):
	f = open(output,'w')
	#2013-08-03T10:07:24+00:00
	dateformat = "%Y-%m-%dT%H:%M:%S+00:00"
	os.system("echo ======================================================================")
	os.system("echo ========= Creating chunks containing equal number of browses =========")
	os.system("echo ======================================================================")
	browses = {}

	#collect all layerids and their start and endtimes
	for files in os.listdir(browsePath):
		xmlfile = parse(browsePath + files)
		typeid = xmlfile.getElementsByTagName('rep:browseType')[0].firstChild.wholeText
		start = strptime(xmlfile.getElementsByTagName('rep:startTime')[0].firstChild.wholeText,dateformat)
		end = strptime(xmlfile.getElementsByTagName('rep:endTime')[0].firstChild.wholeText,dateformat)
		if (typeid in browses):
			browses[typeid].append((start,end))
		else:
			browses[typeid] = [(start,end)]

	#sort by times and create chunks containing a defined number of browses
	for layers in browses:
		browses[layers].sort()
		for i in xrange(0,len(browses[layers]),browsecount):
			next_i = (i+browsecount-1) if ((i+browsecount-1)<len(browses[layers])) else (len(browses[layers])-1)
			out_start = time.strftime(dateformat, browses[layers][i][0])
			out_end = time.strftime(dateformat, browses[layers][next_i][1])
			f.write("%s,%s,%s\n"%(layers,out_start,out_end))





args = parser.parse_args()

if (args.create):
	createChunks(args.create[0], args.create[1], args.chunks)

