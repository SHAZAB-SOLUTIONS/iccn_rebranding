import paramiko
import getpass
import time

sshcli = paramiko.SSHClient()
sshcli.load_system_host_keys()
sshcli.set_missing_host_key_policy(paramiko.AutoAddPolicy())

###############################################################################################################
# Establishing SSH connection with the gateway

ipaddr = input('Enter the IP address of the gateway: ')
usrnm = input('Enter the username with root privileges: ')
pswd = getpass.getpass('Enter the password: ')

# print(f'Connecting to {ipaddr}...')
sshcli.connect(hostname=ipaddr, port=22, username=usrnm, password=pswd, look_for_keys=False, allow_agent=False)
time.sleep(2)

###############################################################################################################
# Invoking shell

shell = sshcli.invoke_shell()
shell.send('8' + '\n')
time.sleep(2)
tmpout1 = shell.recv(10000)
print('Connected!!!')
time.sleep(1)

###############################################################################################################
# Installing required packages if not installed

packages = ['bash', 'jq', 'wget', 'git']
for pkg in packages:
    shell.send(f'pkg info {pkg}' + '\n')
    time.sleep(2)
    tmpout2 = shell.recv(10000)
    if f"pkg: No package(s) matching {pkg}" in tmpout2.decode():
        shell.send(f'pkg install -y {pkg}' + '\n')
        time.sleep(2)
        shell.send('y' + '\n')
        time.sleep(2)
        print(f'{pkg} has been installed!')
    else:
        print(f'{pkg} already installed')

###############################################################################################################
# Running the commands for changes to take place

with open('core_commands.txt') as f:
    commands = f.read().splitlines()
time.sleep(2)
# print(f'Changes taking place on {ipaddr}, Please wait...')
print('changes taking places')
for cmnd in commands:
    print(f'Sending command: {cmnd}')
    shell.send(cmnd + '\n')
    time.sleep(2)
tmpout3 = shell.recv(10000)

###############################################################################################################
# Conditional output to check if the changes have taken place

shell.send("jq '' /usr/local/opnsense/version/core | grep ICCN" + '\n')
time.sleep(2)
tmpout4 = shell.recv(10000)
# print(tmpout4.decode())

print('#' * 120)

if 'ICCN' in tmpout4.decode():
    print('Changes have been changed! Please refresh your GUI and/or clear the cache on your browser.')
else:
    print("Changes haven't been made!!! Please try again.")

###############################################################################################################
# Closing SSH connection with the gateway

if sshcli.get_transport().is_active():
    print('Closing connection...')
    sshcli.close()
