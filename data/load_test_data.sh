#!/bin/sh

curl -d @reference_test_data/browseReport_ASA_IM__0P_20100722_213840.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ASA_IM__0P_20100731_103315.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ASA_IM__0P_20100807_101327.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ASA_IM__0P_20100807_101327_new.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ASA_IM__0P_20100813_102453.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ASA_WS__0P_20100719_101023_group.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ATS_TOA_1P_20100719_105257.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ATS_TOA_1P_20100719_213253.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ATS_TOA_1P_20100722_101606_noid.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ATS_TOA_1P_20100722_101606_specialid.xml http://localhost:3080/browse/ingest
curl -d @reference_test_data/browseReport_ATS_TOA_1P_20100722_101606.xml http://localhost:3080/browse/ingest

curl -d @test_data/ASA_WSM_1PNDPA20050331_075939_000000552036_00035_16121_0775.xml http://localhost:3080/browse/ingest
curl -d @test_data/MER_FRS_1PNPDE20060822_092058_000001972050_00308_23408_0077_RGB_reduced_nogeo.xml http://localhost:3080/browse/ingest
curl -d @test_data/MER_FRS_1PNPDE20060822_092058_000001972050_00308_23408_0077_RGB_reduced.xml http://localhost:3080/browse/ingest

curl -d @aiv_test_data/BrowseReport.xml http://localhost:3080/browse/ingest

curl -d @feed_test_data/BrowseReport.xml http://localhost:3080/browse/ingest
