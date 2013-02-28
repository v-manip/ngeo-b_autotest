#!/bin/sh
#-------------------------------------------------------------------------------
#
# Project: ngEO Browse Server <http://ngeo.eox.at>
# Authors: Fabian Schindler <fabian.schindler@eox.at>
#          Marko Locher <marko.locher@eox.at>
#          Stephan Meissl <stephan.meissl@eox.at>
#
#-------------------------------------------------------------------------------
# Copyright (C) 2013 EOX IT Services GmbH
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
# This script loads the performance demo configuration in an ngEO Browse Server 
# instance.

# Running:
# =======
# sudo ./load_performance_demo_in_ngeo_browse_server.sh

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
echo "load_performance_demo_in_ngeo_browse_server.sh"
echo "==============================================================="

echo "Started loading performance demo data"

# Add browse layers in ngEO Browse Server instance
echo "Adding browse layers in ngEO Browse Server instance."
cd "$NGEOB_INSTALL_DIR/ngeo_browse_server_instance"

cat << EOF >> tmp_browse_layer.json
[
    {
        "pk": "AATRS", 
        "model": "config.browselayer", 
        "fields": {
            "browse_type": "AATRS", 
            "title": "ENVISAT AATRS", 
            "description": "", 
            "browse_access_policy": "OPEN", 
            "contains_vertical_curtains": false, 
            "r_band": null, 
            "g_band": null, 
            "b_band": null, 
            "radiometric_interval_min": null, 
            "radiometric_interval_max": null, 
            "grid": "urn:ogc:def:wkss:OGC:1.0:GoogleCRS84Quad", 
            "lowest_map_level": 0, 
            "highest_map_level": 4
        }
    }, 
    {
        "pk": "ASAR_WS", 
        "model": "config.browselayer", 
        "fields": {
            "browse_type": "ASAR_WS", 
            "title": "ENVISAT ASAR_WS", 
            "description": "", 
            "browse_access_policy": "OPEN", 
            "contains_vertical_curtains": false, 
            "r_band": null, 
            "g_band": null, 
            "b_band": null, 
            "radiometric_interval_min": null, 
            "radiometric_interval_max": null, 
            "grid": "urn:ogc:def:wkss:OGC:1.0:GoogleCRS84Quad", 
            "lowest_map_level": 0, 
            "highest_map_level": 5
        }
    }, 
    {
        "pk": "ASAR_APC", 
        "model": "config.browselayer", 
        "fields": {
            "browse_type": "ASAR_APC", 
            "title": "ENVISAT ASAR_APC", 
            "description": "", 
            "browse_access_policy": "OPEN", 
            "contains_vertical_curtains": false, 
            "r_band": null, 
            "g_band": null, 
            "b_band": null, 
            "radiometric_interval_min": null, 
            "radiometric_interval_max": null, 
            "grid": "urn:ogc:def:wkss:OGC:1.0:GoogleCRS84Quad", 
            "lowest_map_level": 0, 
            "highest_map_level": 5
        }
    }, 
    {
        "pk": "ASAR_IM", 
        "model": "config.browselayer", 
        "fields": {
            "browse_type": "ASAR_IM", 
            "title": "ENVISAT ASAR_IM", 
            "description": "", 
            "browse_access_policy": "OPEN", 
            "contains_vertical_curtains": false, 
            "r_band": null, 
            "g_band": null, 
            "b_band": null, 
            "radiometric_interval_min": null, 
            "radiometric_interval_max": null, 
            "grid": "urn:ogc:def:wkss:OGC:1.0:GoogleCRS84Quad", 
            "lowest_map_level": 0, 
            "highest_map_level": 6
        }
    }, 
    {
        "pk": "ASAR_GM", 
        "model": "config.browselayer", 
        "fields": {
            "browse_type": "ASAR_GM", 
            "title": "ENVISAT ASAR_GM", 
            "description": "", 
            "browse_access_policy": "OPEN", 
            "contains_vertical_curtains": false, 
            "r_band": null, 
            "g_band": null, 
            "b_band": null, 
            "radiometric_interval_min": null, 
            "radiometric_interval_max": null, 
            "grid": "urn:ogc:def:wkss:OGC:1.0:GoogleCRS84Quad", 
            "lowest_map_level": 0, 
            "highest_map_level": 5
        }
    }, 
    {
        "pk": "MERIS_RR", 
        "model": "config.browselayer", 
        "fields": {
            "browse_type": "MERIS_RR", 
            "title": "ENVISAT MERIS_RR", 
            "description": "", 
            "browse_access_policy": "OPEN", 
            "contains_vertical_curtains": false, 
            "r_band": null, 
            "g_band": null, 
            "b_band": null, 
            "radiometric_interval_min": null, 
            "radiometric_interval_max": null, 
            "grid": "urn:ogc:def:wkss:OGC:1.0:GoogleCRS84Quad", 
            "lowest_map_level": 0, 
            "highest_map_level": 3
        }
    }, 
    {
        "pk": "MERIS_FR", 
        "model": "config.browselayer", 
        "fields": {
            "browse_type": "MERIS_FR", 
            "title": "ENVISAT MERIS_FR", 
            "description": "", 
            "browse_access_policy": "OPEN", 
            "contains_vertical_curtains": false, 
            "r_band": null, 
            "g_band": null, 
            "b_band": null, 
            "radiometric_interval_min": null, 
            "radiometric_interval_max": null, 
            "grid": "urn:ogc:def:wkss:OGC:1.0:GoogleCRS84Quad", 
            "lowest_map_level": 0, 
            "highest_map_level": 4
        }
    }
]
EOF
cat << EOF >> tmp_mapcache.json
[
    {
        "pk": "AATRS", 
        "model": "mapcache.source", 
        "fields": {}
    }, 
    {
        "pk": "ASAR_WS", 
        "model": "mapcache.source", 
        "fields": {}
    }, 
    {
        "pk": "ASAR_APC", 
        "model": "mapcache.source", 
        "fields": {}
    }, 
    {
        "pk": "ASAR_IM", 
        "model": "mapcache.source", 
        "fields": {}
    }, 
    {
        "pk": "ASAR_GM", 
        "model": "mapcache.source", 
        "fields": {}
    }, 
    {
        "pk": "MERIS_RR", 
        "model": "mapcache.source", 
        "fields": {}
    }, 
    {
        "pk": "MERIS_FR", 
        "model": "mapcache.source", 
        "fields": {}
    }
]
EOF
python manage.py loaddata tmp_browse_layer.json
python manage.py loaddata --database=mapcache tmp_mapcache.json
rm tmp_browse_layer.json tmp_mapcache.json

python manage.py eoxs_add_dataset_series --id AATRS
python manage.py eoxs_add_dataset_series --id ASAR_WS
python manage.py eoxs_add_dataset_series --id ASAR_APC
python manage.py eoxs_add_dataset_series --id ASAR_IM
python manage.py eoxs_add_dataset_series --id ASAR_GM
python manage.py eoxs_add_dataset_series --id MERIS_RR
python manage.py eoxs_add_dataset_series --id MERIS_FR


# Add browse laysers in MapCache
echo "Adding browse layers in MapCache."
cd "$MAPCACHE_DIR"
if ! grep -Fxq "    <cache name=\"AATRS\" type=\"sqlite3\">" $MAPCACHE_CONF ; then
    sed -e "/^<\/mapcache>$/d" -i $MAPCACHE_CONF
    cat << EOF >> $MAPCACHE_CONF

    <cache name="AATRS" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/AATRS.sqlite</dbfile>
    </cache>
    <cache name="ASAR_WS" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/ASAR_WS.sqlite</dbfile>
    </cache>
    <cache name="ASAR_APC" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/ASAR_APC.sqlite</dbfile>
    </cache>
    <cache name="ASAR_IM" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/ASAR_IM.sqlite</dbfile>
    </cache>
    <cache name="ASAR_GM" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/ASAR_GM.sqlite</dbfile>
    </cache>
    <cache name="MERIS_RR" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/MERIS_RR.sqlite</dbfile>
    </cache>
    <cache name="MERIS_FR" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/MERIS_FR.sqlite</dbfile>
    </cache>

    <source name="AATRS" type="wms">
        <getmap>
            <params>
                <LAYERS>AATRS</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>
    <source name="ASAR_WS" type="wms">
        <getmap>
            <params>
                <LAYERS>ASAR_WS</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>
    <source name="ASAR_APC" type="wms">
        <getmap>
            <params>
                <LAYERS>ASAR_APC</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>
    <source name="ASAR_IM" type="wms">
        <getmap>
            <params>
                <LAYERS>ASAR_IM</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>
    <source name="ASAR_GM" type="wms">
        <getmap>
            <params>
                <LAYERS>ASAR_GM</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>
    <source name="MERIS_RR" type="wms">
        <getmap>
            <params>
                <LAYERS>MERIS_RR</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>
    <source name="MERIS_FR" type="wms">
        <getmap>
            <params>
                <LAYERS>MERIS_FR</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>

    <tileset name="AATRS">
        <source>AATRS</source>
        <cache>AATRS</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>8 8</metatile>
        <expires>3600</expires>
        <read-only>true</read-only>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>
    <tileset name="ASAR_WS">
        <source>ASAR_WS</source>
        <cache>ASAR_WS</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>8 8</metatile>
        <expires>3600</expires>
        <read-only>true</read-only>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>
    <tileset name="ASAR_APC">
        <source>ASAR_APC</source>
        <cache>ASAR_APC</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>8 8</metatile>
        <expires>3600</expires>
        <read-only>true</read-only>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>
    <tileset name="ASAR_IM">
        <source>ASAR_IM</source>
        <cache>ASAR_IM</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>8 8</metatile>
        <expires>3600</expires>
        <read-only>true</read-only>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>
    <tileset name="ASAR_GM">
        <source>ASAR_GM</source>
        <cache>ASAR_GM</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>8 8</metatile>
        <expires>3600</expires>
        <read-only>true</read-only>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>
    <tileset name="MERIS_RR">
        <source>MERIS_RR</source>
        <cache>MERIS_RR</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>8 8</metatile>
        <expires>3600</expires>
        <read-only>true</read-only>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>
    <tileset name="MERIS_FR">
        <source>MERIS_FR</source>
        <cache>MERIS_FR</cache>
        <grid>WGS84</grid>
        <format>mixed</format>
        <metatile>8 8</metatile>
        <expires>3600</expires>
        <read-only>true</read-only>
        <timedimension type="sqlite" default="2010">
            <dbfile>$NGEOB_INSTALL_DIR/ngeo_browse_server_instance/ngeo_browse_server_instance/data/mapcache.sqlite</dbfile>
            <query>select strftime('%Y-%m-%dT%H:%M:%SZ',start_time)||'/'||strftime('%Y-%m-%dT%H:%M:%SZ',end_time) from time where source_id=:tileset and start_time&gt;=datetime(:start_timestamp,'unixepoch') and end_time&lt;=datetime(:end_timestamp,'unixepoch') order by end_time</query>
        </timedimension>
    </tileset>
</mapcache>
EOF
fi

# Reload Apache
service httpd reload

cat <<EOF

################################################################################
#                                                                              #
#           Ingest browse reports either via command line or via URL           #
#                                                                              #
################################################################################

# Obtain performance test browse reports and browse images and run performance
# tests via JMeter.

# Alternatively run the following manually.
# Upload browse images using WebDAV:
curl --digest -u username:password -T <PATH-TO-BROWSE-IMAGE> <URL>/store
# Ingest browse reports using curl:
curl -d @<PATH-TO-BROWSE-REPORT> <URL>/browse/ingest
# or the ngeo_ingest_browse_report command:
cd "$NGEOB_INSTALL_DIR/ngeo_browse_server_instance"
python manage.py ngeo_ingest_browse_report <PATH-TO-BROWSE-REPORT>

EOF

echo "Finished loading performance demo data"
