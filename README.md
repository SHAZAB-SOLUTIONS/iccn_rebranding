# iccn-rebranding

ICCN AWGateway default theme is based on the tukan theme available in OPNsense packages. It has its own logos.
But sometimes on updating the firmware the logos revert back to OPNsense logos. Also the copyright names and links (core file content) revert back to OPNsense.
When that happens, one can follow either of the following steps. These aare simple scripts one can run to see the changes back to ICCN.
One method is a bash script that should run on the shell of the gateway and the other is a python script, which can be run remotely as well.

There are three scripts for each method. It depends on three different scenarios:

1. Only logos have reverted back to OPNsense

  For this one can run iccnlogo.sh on their gateway's shell after cloning this repository on their gateway. If git package is not available kindly run the iccnlogo.py
  script or use the following command to install git package.
  
              pkg install -y git
              
  How iccnlogo.sh works?
  
    There is a repository named iccn-theme wherein are stored latest iccn logos. The bash script clones that repository and downloads all the images. It then changes
    its directory to the downloaded iccn-theme/ directory and then copies all the images to the main file where all the logos are present on the gateway responisble
    for GUI changes. It then deletes the iccn-theme/ directory, so that next the same issue arises, the folders would not overlap.


  Another way the logos can be reverted is by running the python script iccnlogo.py. One needs to be in one of the same networks the gateway is connected (either VPN
  or LAN). When downloading the script make sure one downloads the commands.txt file along with it and save both the pyhton script and the txt file on the same
  directory.
  
  How it works?
  
    This script uses Paramiko module to establish the ssh connection to the gateway and runs a series of commands for hte changes to take place. At the start one is 
    asked to enter the IP address of the gateway, user with root privileges and its password. After that just sit back and relax while the changes take place.
    
2. Only the core file content has changed

  One can either run the iccncore.sh or iccncore.py. Here we are trying to edit /usr/local/opnsense/version/core file which contains json data abot copyright owner,
  url, name and links associated with the gateway. The process is same either run the bash file iccncore.sh or run the python script iccncore.py
 
3. Both logos and core file content has changed

  For this we have created a script combining both the above type of scripts.
  
Note: After cloning this repository (iccn-rebranding), one needs to change to the directory iccn-rebranding/ and one can find all the scripts and file of the repo 
there. 

Hope this helps!!!
