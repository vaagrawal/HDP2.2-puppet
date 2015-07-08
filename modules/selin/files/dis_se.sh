#! /bin/bash
sudo sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux 
sudo sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
