#!/bin/sh
#-------------------------------------------------------------------------------
#
# Project: ngEO Browse Server <http://ngeo.eox.at>
# Authors: Fabian Schindler <fabian.schindler@eox.at>
#          Marko Locher <marko.locher@eox.at>
#          Stephan Meissl <stephan.meissl@eox.at>
#
#-------------------------------------------------------------------------------
# Copyright (C) 2012 EOX IT Services GmbH
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies of this Software or works derived from this Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#-------------------------------------------------------------------------------

# About:
# =====
# This script loads the demo/test data in an ngEO Browse Server instance via 
# HTTP POST.

# Running:
# =======
# sudo ./load_test_data.sh [URL]

################################################################################
# Usually there should be no need to change anything below.                    #
################################################################################

url=$1

[ "$1" ]] || url="http://localhost:3080"

echo "Sending browse reports to: $url"

curl --digest -u test:eiNoo7ae -T data/reference_test_data/ASA_IM__0P_20100722_213840.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ASA_IM__0P_20100731_103315.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ASA_IM__0P_20100807_101327.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ASA_IM__0P_20100807_101327_new.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ASA_IM__0P_20100813_102453.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ASA_WS__0P_20100719_101023.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ASA_WS__0P_20100722_101601.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ASA_WS__0P_20100725_102231.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ATS_TOA_1P_20100719_105257.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ATS_TOA_1P_20100719_213253.jpg "$url"/store/
curl --digest -u test:eiNoo7ae -T data/reference_test_data/ATS_TOA_1P_20100722_101606.jpg "$url"/store/
 
curl --digest -u test:eiNoo7ae -T data/test_data/ASA_WSM_1PNDPA20050331_075939_000000552036_00035_16121_0775.tif "$url"/store/
curl --digest -u test:eiNoo7ae -T data/test_data/MER_FRS_1PNPDE20060822_092058_000001972050_00308_23408_0077_RGB_reduced_nogeo.tif "$url"/store/
curl --digest -u test:eiNoo7ae -T data/test_data/MER_FRS_1PNPDE20060822_092058_000001972050_00308_23408_0077_RGB_reduced.tif "$url"/store/

curl --digest -u test:eiNoo7ae -T data/aiv_test_data/NGEO-FEED-VTC-0040.jpg "$url"/store/

curl --digest -u test:eiNoo7ae -T data/feed_test_data/quick-look.png "$url"/store/


curl -d @data/reference_test_data/browseReport_ASA_IM__0P_20100722_213840.xml "$url"/browse/ingest
curl -d @data/reference_test_data/browseReport_ASA_IM__0P_20100731_103315.xml "$url"/browse/ingest
curl -d @data/reference_test_data/browseReport_ASA_IM__0P_20100807_101327.xml "$url"/browse/ingest
curl -d @data/reference_test_data/browseReport_ASA_IM__0P_20100807_101327_new.xml "$url"/browse/ingest
curl -d @data/reference_test_data/browseReport_ASA_IM__0P_20100813_102453.xml "$url"/browse/ingest
curl -d @data/reference_test_data/browseReport_ASA_WS__0P_20100719_101023_group.xml "$url"/browse/ingest
curl -d @data/reference_test_data/browseReport_ATS_TOA_1P_20100719_105257.xml "$url"/browse/ingest
curl -d @data/reference_test_data/browseReport_ATS_TOA_1P_20100719_213253.xml "$url"/browse/ingest
curl -d @data/reference_test_data/browseReport_ATS_TOA_1P_20100722_101606.xml "$url"/browse/ingest

curl -d @data/test_data/ASA_WSM_1PNDPA20050331_075939_000000552036_00035_16121_0775.xml "$url"/browse/ingest
curl -d @data/test_data/MER_FRS_1PNPDE20060822_092058_000001972050_00308_23408_0077_RGB_reduced_nogeo.xml "$url"/browse/ingest
curl -d @data/test_data/MER_FRS_1PNPDE20060822_092058_000001972050_00308_23408_0077_RGB_reduced.xml "$url"/browse/ingest

curl -d @data/aiv_test_data/BrowseReport.xml "$url"/browse/ingest

curl -d @data/feed_test_data/BrowseReport.xml "$url"/browse/ingest
