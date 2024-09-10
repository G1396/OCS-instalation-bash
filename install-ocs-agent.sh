#!/bin/bash

# Updating and upgrading packages
echo "Updating and upgrading packages..."
sudo apt update -y
sudo apt upgrade -y

# Install expect to automate the installation
echo "Installing o expect..."
sudo apt-get install -y expect

# Downloading the script expect
echo "Downloading the script expect..."
cat <<EOF > expect.exp
#!/usr/bin/expect -f

# Sets the waiting time
set timeout -1

# Initiate commands
spawn sudo perl Makefile.PL

# Automatically answers questions
expect "Do you want to continue? [y/N] "
send "y\r"

expect "Choose installation directory:"
send "2\r"

expect "Do you want to install required Perl modules? [y/N] "
send "y\r"

expect "Do you want to configure the OCS Inventory Agent now? [y/N] "
send "y\r"

expect "Enter the OCS Inventory server URL:"
send "http://your.ocs.server/ocsinventory\r" 
# For example: 10.0.0.1

expect "Do you want to enable the OCS Inventory Agent service now? [y/N] "
send "y\r"

# Finishes interaction
expect eof
EOF

# Makes the expected script executable and executes
chmod +x expect.exp
echo "Running expect script..."
./expect.exp

# Install necessary packages
echo "Installing necessary packages..."
sudo apt install -y make gcc libmodule-install-perl dmidecode libxml-simple-perl libcompress-zlib-perl openssl libnet-ip-perl libwww-perl libdigest-md5-perl libdata-uuid-perl libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl net-tools libsys-syslog-perl pciutils smartmontools read-edid nmap libnet-netmask-perl

# Download the file
echo "Downloading the OCS Inventory agent file..."
sudo wget https://github.com/OCSInventory-NG/UnixAgent/releases/download/v2.10.2/Ocsinventory-Unix-Agent-2.10.2.tar.gz

# Extracts the file
echo "Extracting the file..."
sudo tar -xvf Ocsinventory-Unix-Agent-2.10.2.tar.gz

# Changes to extracted directory
cd Ocsinventory-Unix-Agent-2.10.2

# Compile and install the package
echo "Compiling and installing the package."
sudo perl Makefile.PL
sudo make
sudo make install

echo "Installation completed successfully!"
