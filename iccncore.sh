#!/bin/bash

# Editing the core file for changing from OPNsense copyright to ICCN

#Path of core file
cd /usr/local/opnsense/version/

# Since the core file is json data, we will be needing the 'jq' package

pkg_name=jq
out1=$(pkg info $pkg_name | grep Name)
compare_string="Name           : $pkg_name"

if [ "$out1" == "$compare_string" ]
then
    echo "Package: $pkg_name already installed. Executing the commands to make changes in the core file!!!"
else
    echo "$pkg_name not installed. Installing ' $pkg_name ' ..."
    pkg install -y $pkg_name
fi

# Making changes in the JSON file

jq '.product_copyright_owner = "ICCN"' core > test.json && mv test.json core
jq '.product_copyright_url = "https://www.iccnetworking.com"' core > test.json && mv test.json core
jq '.product_email = "info@iccnetworking.com"' core > test.json && mv test.json core
jq '.product_name = "AGW"' core > test.json && mv test.json core
jq '.product_nickname = "AGW"' core > test.json && mv test.json core
jq '.product_website = "https://www.iccnetworking.com"' core > test.json && mv test.json core

out2=$(jq '.product_copyright_owner' /usr/local/opnsense/version/core)
# echo $out2

if [ "$out2" == '"ICCN"' ]
then
        echo "Changes have been made in the core file!!! Please refresh and/or clear cache on your browser to see the changes."
else
        echo "Changes in the core file have not been made. Please try again."
fi

