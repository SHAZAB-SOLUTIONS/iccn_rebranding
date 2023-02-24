#!/bin/bash

# Going into the iccn-logos directory to copy images to the directory for changing to ICCN Theme from OPNsense

cd ../iccn-logos/
if [ -d /root/iccn-rebranding/iccn-logos ]
then
	cp *.* /usr/local/opnsense/www/themes/tukan/build/images/
	echo "Logos have been changed! Please refresh you Web GUI and/or clear your browser cache to see the results."
else
	echo "No changes in logos have taken place. Please try again!!!"
fi

