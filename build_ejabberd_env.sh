#!/bin/bash

# This script makes development environment for ejabberd.
# For execution this script, you should be the superuser.

if [ $(id -u) != "0" ]; then
echo "You must be the superuser to run this script" >&2
exit 1
fi

#############################################
## 1) basic install
#############################################

# update package list
apt-get update

# install build tool(gcc, g++, make)
apt-get -y install build-essential

# install automatic configure script builder
apt-get -y install autoconf

# install libncurses5
apt-get -y install libncurses5-dev

# install odbc
apt-get -y install unixodbc-dev

# install ssl
apt-get -y install libssh-dev

# install wget
apt-get -y install wget

#############################################
## 2) build erlang
#############################################

mkdir -p ~/src/erlang
cd ~/src/erlang

if [ -e otp_src_17.1.tar.gz ]; then
echo "'otp_src_17.1.tar.gz' already exists. Skipping download."
else
wget http://www.erlang.org/download/otp_src_17.1.tar.gz
fi

tar -xvzf otp_src_17.1.tar.gz
chmod -R 777 otp_src_17.1
cd otp_src_17.1
./configure
make
make install


#############################################
## 3) build ejabberd
#############################################

# install yaml
apt-get -y install libyaml-dev

# install expat
apt-get -y install libexpat1 libexpat1-dev

# install sqlite3
apt-get -y install sqlite3 libsqlite3-dev

# install pam 
apt-get -y install libpam0g-dev

cd ~/src/
git clone git://github.com/processone/ejabberd.git
cd ejabberd
./autogen.sh
./configure --enable-all
make install
