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
# This script loads demo configuration in an ngEO Browse Server instance.

# Running:
# =======
# sudo ./load_demo_in_ngeo_browse_server.sh

################################################################################
# Adjust the variables to your liking.                                         #
################################################################################

# ngEO Browse Server
NGEOB_INSTALL_DIR="/var/www/ngeo"

# MapCache
MAPCACHE_DIR="/var/www/cache"
MAPCACHE_CONF="mapcache.xml"

################################################################################
# Usually there should be no need to change anything below.                    #
################################################################################

echo "==============================================================="
echo "load_demo_in_ngeo_browse_server.sh"
echo "==============================================================="

echo "Started loading demo data"

# Add browse layers in ngEO Browse Server instance
echo "Adding browse layers in ngEO Browse Server instance."
cd "$NGEOB_INSTALL_DIR/ngeo_browse_server_instance"
python manage.py loaddata ngeo_browse_layer.json eoxs_dataset_series.json
python manage.py loaddata --database=mapcache ngeo_mapcache.json


# Add browse laysers in MapCache
echo "Adding browse laysers in MapCache."
cd "$MAPCACHE_DIR"
if ! grep -Fxq "    <service type=\"demo\" enabled=\"true\"/>" $MAPCACHE_CONF ; then
    sed -e "/^<\/mapcache>$/d" -i $MAPCACHE_CONF
    sed -e "/^<\/mapcache>$/d" -i seed_$MAPCACHE_CONF
    cat << EOF >> $MAPCACHE_CONF

    <cache name="TEST_SAR" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/TEST_SAR.sqlite</dbfile>
    </cache>

    <cache name="TEST_OPTICAL" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/TEST_OPTICAL.sqlite</dbfile>
    </cache>

    <cache name="TEST_ASA_WSM" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/TEST_ASA_WSM.sqlite</dbfile>
    </cache>

    <cache name="TEST_MER_FRS" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/TEST_MER_FRS.sqlite</dbfile>
    </cache>

    <tileset name="TEST_SAR">
        <cache>TEST_SAR</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>2 2</metatile>
        <metabuffer>10</metabuffer>
        <expires>3600</expires>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>

    <tileset name="TEST_OPTICAL">
        <cache>TEST_OPTICAL</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>2 2</metatile>
        <metabuffer>10</metabuffer>
        <expires>3600</expires>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>

    <tileset name="TEST_ASA_WSM">
        <cache>TEST_ASA_WSM</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>2 2</metatile>
        <metabuffer>10</metabuffer>
        <expires>3600</expires>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>

    <tileset name="TEST_MER_FRS">
        <cache>TEST_MER_FRS</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>2 2</metatile>
        <metabuffer>10</metabuffer>
        <expires>3600</expires>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>

    <service type="demo" enabled="true"/>
</mapcache>
EOF
    cat << EOF >> seed_$MAPCACHE_CONF

    <cache name="TEST_SAR" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/TEST_SAR.sqlite</dbfile>
    </cache>

    <cache name="TEST_OPTICAL" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/TEST_OPTICAL.sqlite</dbfile>
    </cache>

    <cache name="TEST_ASA_WSM" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/TEST_ASA_WSM.sqlite</dbfile>
    </cache>

    <cache name="TEST_MER_FRS" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/TEST_MER_FRS.sqlite</dbfile>
    </cache>

    <source name="TEST_SAR" type="wms">
        <getmap>
            <params>
                <LAYERS>TEST_SAR</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>

    <source name="TEST_OPTICAL" type="wms">
        <getmap>
            <params>
                <LAYERS>TEST_OPTICAL</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>

    <source name="TEST_ASA_WSM" type="wms">
        <getmap>
            <params>
                <LAYERS>TEST_ASA_WSM</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>

    <source name="TEST_MER_FRS" type="wms">
        <getmap>
            <params>
                <LAYERS>TEST_MER_FRS</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>

    <tileset name="TEST_SAR">
        <source>TEST_SAR</source>
        <cache>TEST_SAR</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>2 2</metatile>
        <metabuffer>10</metabuffer>
        <expires>3600</expires>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>

    <tileset name="TEST_OPTICAL">
        <source>TEST_OPTICAL</source>
        <cache>TEST_OPTICAL</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>2 2</metatile>
        <metabuffer>10</metabuffer>
        <expires>3600</expires>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>

    <tileset name="TEST_ASA_WSM">
        <source>TEST_ASA_WSM</source>
        <cache>TEST_ASA_WSM</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>2 2</metatile>
        <metabuffer>10</metabuffer>
        <expires>3600</expires>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>

    <tileset name="TEST_MER_FRS">
        <source>TEST_MER_FRS</source>
        <cache>TEST_MER_FRS</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>2 2</metatile>
        <metabuffer>10</metabuffer>
        <expires>3600</expires>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>

    <service type="demo" enabled="true"/>
</mapcache>
EOF
fi

# Reload Apache
service httpd graceful

cat <<EOF

################################################################################
#                                                                              #
#           Ingest browse reports either via command line or via URL           #
#                                                                              #
################################################################################

# Obtain test browse reports and browse images and run "load_test_data.sh".

# Alternatively run the following manually.
# Upload browse images using WebDAV:
curl --digest -u username:password -T <PATH-TO-BROWSE-IMAGE> <URL>/store
# Ingest browse reports using curl:
curl -d @<PATH-TO-BROWSE-REPORT> <URL>/browse/ingest
# or the ngeo_ingest_browse_report command:
cd "$NGEOB_INSTALL_DIR/ngeo_browse_server_instance"
python manage.py ngeo_ingest_browse_report <PATH-TO-BROWSE-REPORT>

EOF

echo "Finished loading demo data"