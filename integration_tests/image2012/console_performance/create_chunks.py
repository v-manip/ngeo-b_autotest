import csv
import argparse
import time
import os
from time import gmtime, strptime, strftime
import itertools, collections
import uuid

import pdb

from datetime import datetime, timedelta
from xml.dom.minidom import parse, parseString


def consume(iterator, n):
    collections.deque(itertools.islice(iterator, n))


#argument specification for script
parser = argparse.ArgumentParser(description='Script which allows to create a csv which separates browse reports in equaly sized chunks of times')

parser.add_argument('--create', nargs=2,
                   help='Pass arguments with path to browse reports and output csv filepath')

parser.add_argument('--output', nargs=1, default='modifiedBrowses/',
                   help='Pass path to where output shall be saved, default is modifiedBrowses/')


def createChunks(browsePath, outputfile, output):
	f = open(outputfile,'w')
	#2013-08-03T10:07:24+00:00
	dateformat = "%Y-%m-%dT%H:%M:%S+00:00"
	os.system("echo ======================================================================")
	os.system("echo ========= Creating chunks containing equal number of browses =========")
	os.system("echo ======================================================================")
	browses = {}
	browsereports = []

	#collect all layerids and their start and endtimes
	for filename in os.listdir(browsePath):
		export = output + filename
		filename = browsePath + filename
		xmlfile = parse(filename)
		typeid = xmlfile.getElementsByTagName('rep:browseType')[0].firstChild.wholeText
		start = datetime.strptime(xmlfile.getElementsByTagName('rep:startTime')[0].firstChild.wholeText, dateformat)
		end = datetime.strptime(xmlfile.getElementsByTagName('rep:endTime')[0].firstChild.wholeText, dateformat)
		
		browses.setdefault(typeid, []).append([start, end, xmlfile])
		browsereports.append((xmlfile, export))

	#sort by times, modify browse report times so they dont overlap 
	#and write start and entime for each browsereport
	for layers in browses:
		browses[layers].sort()

		iterator = enumerate(browses[layers]).__iter__()

		for i, (start, end, xmlfile) in iterator:

			
			next_i = (i+1) if ((i+1)<len(browses[layers])) else -1
			amount_overlap = 0

			if next_i > -1:
				#while end_time is bigger then start_time of the next browsereport
				while end >= browses[layers][next_i][0]: 
					#count how many overlap
					amount_overlap += 1

					#check if we reached last element in list
					if( next_i+1 >= len(browses[layers]) ):
						break

					#increment next_i to compare next browse report times in next loop
					next_i += 1

				if (amount_overlap > 0):
					min_start = browses[layers][i][0] 
					max_end = browses[layers][next_i][1]
					#time_interval = ((max_end - min_start) + timedelta(seconds=10)) /amount_overlap
					time_interval = (max_end - min_start) /amount_overlap
				else:
					min_start = browses[layers][i][0] 
					max_end = browses[layers][i][1]
					time_interval = (max_end - min_start)


				multiplier = 0
				if amount_overlap > 0:
					for j in xrange(i, next_i+1):

						browses[layers][j][0] = (min_start + time_interval*multiplier) + timedelta(seconds=1)
						multiplier = multiplier+1
						browses[layers][j][1] = (min_start + time_interval*multiplier)

						#pdb.set_trace()

						out_start = browses[layers][j][0].strftime(dateformat)
						out_end = browses[layers][j][1].strftime(dateformat)

						#Modify browse reports with new start end times
						browses[layers][j][2].getElementsByTagName('rep:startTime')[0].firstChild.replaceWholeText(out_start)
						browses[layers][j][2].getElementsByTagName('rep:endTime')[0].firstChild.replaceWholeText(out_end)

						#Modify id of layer to avoid overwriting browses
						browses[layers][j][2].getElementsByTagName('rep:browseIdentifier')[0].firstChild.replaceWholeText("_"+str(uuid.uuid4()))

						#write layerid start and end times of browse to the csv
						f.write("%s,%s,%s\n"%(layers,out_start,out_end))

					#browse reports already analyses (time overlapped) can be jumped over					
					consume(iterator,amount_overlap)

				else:
					browses[layers][i][0] = min_start
					browses[layers][i][1] = max_end

					out_start = browses[layers][i][0].strftime(dateformat)
					out_end = browses[layers][i][1].strftime(dateformat)

					#Modify browse reports with new start end times
					browses[layers][i][2].getElementsByTagName('rep:startTime')[0].firstChild.replaceWholeText(out_start)
					browses[layers][i][2].getElementsByTagName('rep:endTime')[0].firstChild.replaceWholeText(out_end)

					#Modify id of layer to avoid overwriting browses
					browses[layers][i][2].getElementsByTagName('rep:browseIdentifier')[0].firstChild.replaceWholeText("_"+str(uuid.uuid4()))

					#write layerid start and end times of browse to the csv
					f.write("%s,%s,%s\n"%(layers,out_start,out_end))

	
	for dom, filename in browsereports:
		with open(filename, "w+") as xmlf:
			xmlf.write(dom.toxml("utf-8"))


	#Check there are actually no overlapping times
	for layers in browses:
		browses[layers].sort()

		for i, (start, end, xmlfile) in enumerate(browses[layers]):
			next_i = (i+1) if ((i+1)<len(browses[layers])) else -1
			if next_i > -1:
				if end >= browses[layers][next_i][0]: 
					print "OVERLAP FOUND!!"


args = parser.parse_args()

if (args.create):
	createChunks(args.create[0], args.create[1], args.output[0])

