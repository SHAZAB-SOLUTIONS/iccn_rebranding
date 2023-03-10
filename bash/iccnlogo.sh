#!/bin/bash

# Going into the iccn-logos directory to copy images to the directory for changing to ICCN Theme from OPNsense

cd ../iccn-logos/
if [ -d /root/iccn-rebranding/iccn-logos ]
then
    out1=$(pkg info os-theme-tukan | grep Name)
    compare_string="Name           : os-theme-tukan-1.26"

    if [ "$out1" == "$compare_string" ]
    then
        echo "Package: os-theme-tukan-1.26 already installed."
	cp *.* /usr/local/opnsense/www/themes/tukan/build/images/
    else
        echo "os-theme-tukan-1.26 is not installed. Installing os-theme-tukan-1.26 ..."
        pkg install -y os-theme-tukan-1.26
	cp *.* /usr/local/opnsense/www/themes/tukan/build/images/
    fi
else
    echo "No changes in logos have taken place. Please try again!!!"
fi
