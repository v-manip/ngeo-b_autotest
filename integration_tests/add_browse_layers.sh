#!/bin/bash
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
# This script adds Browse Layers in an ngEO Browse Server instance.
#
# Browse Layers are provided in a separate configuration file following this
# structure:
#<LAYER_NAME> <BROWSE_TYPE> <LOWEST_MAP_LEVEL> <HIGHEST_MAP_LEVEL>

# Running:
# =======
# sudo ./add_browse_layers.sh <FILENAME>

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
echo "add_browse_layers.sh"
echo "==============================================================="

echo "Started adding browse layers."

FILENAME=$1

[ "$1" ] || FILENAME="browse_layers_reference_tests.cfg"

while read BROWSE_LAYER
do
    # Skip commented lines
    [[ $BROWSE_LAYER == \#* ]] && continue

    LAYER_NAME=$(echo $BROWSE_LAYER | cut -f1 -d " ")
    BROWSE_TYPE=$(echo $BROWSE_LAYER | cut -f2 -d " ")
    LOWEST_MAP_LEVEL=$(echo $BROWSE_LAYER | cut -f3 -d " ")
    HIGHEST_MAP_LEVEL=$(echo $BROWSE_LAYER | cut -f4 -d " ")
    echo "    Adding browse layer '$LAYER_NAME' for browse type '$BROWSE_TYPE'."

    # Add in Django apps
    cd "$NGEOB_INSTALL_DIR/ngeo_browse_server_instance"
    python manage.py eoxs_check_id -a $BROWSE_TYPE
    if [ $? -eq 0 ]; then
        echo "         Adding in Django apps."
        cat << EOF >> tmp_browse_layer.json
[
    {
        "pk": "$LAYER_NAME", 
        "model": "config.browselayer", 
        "fields": {
            "browse_type": "$BROWSE_TYPE", 
            "title": "$BROWSE_TYPE", 
            "description": "", 
            "browse_access_policy": "OPEN", 
            "contains_vertical_curtains": false, 
            "r_band": null, 
            "g_band": null, 
            "b_band": null, 
            "radiometric_interval_min": null, 
            "radiometric_interval_max": null, 
            "grid": "urn:ogc:def:wkss:OGC:1.0:GoogleCRS84Quad", 
            "lowest_map_level": $LOWEST_MAP_LEVEL, 
            "highest_map_level": $HIGHEST_MAP_LEVEL
        }
    }
]
EOF
        cat << EOF >> tmp_mapcache.json
[
    {
        "pk": "$LAYER_NAME", 
        "model": "mapcache.source", 
        "fields": {}
    }
]
EOF
        python manage.py loaddata tmp_browse_layer.json
        python manage.py loaddata --database=mapcache tmp_mapcache.json
        rm tmp_browse_layer.json tmp_mapcache.json
        python manage.py eoxs_add_dataset_series --id $LAYER_NAME
    fi
    cd - > /dev/null

    # Add in MapCache
    cd "$MAPCACHE_DIR"
    if ! grep -Fxq "    <cache name=\"$LAYER_NAME\" type=\"sqlite3\">" $MAPCACHE_CONF ; then
        echo "        Adding in MapCache."
        sed -e "/^<\/mapcache>$/d" -i $MAPCACHE_CONF
        cat << EOF >> $MAPCACHE_CONF

    <cache name="$LAYER_NAME" type="sqlite3">
        <dbfile>$MAPCACHE_DIR/$LAYER_NAME.sqlite</dbfile>
    </cache>
    <source name="$LAYER_NAME" type="wms">
        <getmap>
            <params>
                <LAYERS>$LAYER_NAME</LAYERS>
                <TRANSPARENT>true</TRANSPARENT>
            </params>
        </getmap>
        <http>
            <url>http://localhost/browse/ows?</url>
        </http>
    </source>
    <tileset name="$LAYER_NAME">
        <source>$LAYER_NAME</source>
        <cache>$LAYER_NAME</cache>
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
    cd - > /dev/null

done < $FILENAME
echo "Finished adding browse layers."

# Reload Apache
service httpd reload

cat <<EOF

################################################################################
#                                                                              #
#           Ingest browse reports either via command line or via URL           #
#                                                                              #
################################################################################

# Obtain a feed instance and run integration tests.

# Alternatively run the following manually.
# Upload browse images using WebDAV:
curl --digest -u username:password -T <PATH-TO-BROWSE-IMAGE> <URL>/store
# Ingest browse reports using curl:
curl -d @<PATH-TO-BROWSE-REPORT> <URL>/browse/ingest
# or the ngeo_ingest_browse_report command:
cd "$NGEOB_INSTALL_DIR/ngeo_browse_server_instance"
python manage.py ngeo_ingest_browse_report <PATH-TO-BROWSE-REPORT>

EOF
