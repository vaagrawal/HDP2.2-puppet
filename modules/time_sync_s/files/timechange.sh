#! /bin/bash

sudo cp /etc/localtime /tmp/old.timezone
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
echo "Date updated!"
sudo date
