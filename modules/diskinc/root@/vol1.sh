#! /bin/bash

if rpm -qa | grep -q parted 
then
echo "Parted is installed"
else 
echo "Installing parted"
sudo yum install parted
fi


