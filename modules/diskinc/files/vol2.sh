#!/bin/bash

DNAME=$( lsblk | grep disk | awk '{print $1}')
CDN=/dev/$DNAME

DSTART=$(sudo parted /dev/vda p | grep lvm| awk '{print $3}')
PINDEX=$(sudo parted /dev/vda p | grep lvm| awk '{print $1}')
PINDEX=`expr $PINDEX + 1`

DEND=$(sudo fdisk -l | grep Disk | grep GB | awk '{print $3}')
TEMP="GB"
DEND=$DEND$TEMP

VOLFULL=$(lsblk | grep dm | sed '/SWAP/d' |  awk '{print $1}')

IFS='-' read -ra ADDR <<< "$VOLFULL"

LOGVOL=${ADDR[1]}
VOLGR=$(sudo vgdisplay | awk '{print $3}' | awk 'NR==2')

CDNAME=/dev/$DNAME

echo "Making partition"
sudo parted $CDNAME mkpart primary $DSTART $DEND > /dev/null
sudo parted $CDNAME set $PINDEX lvm on > /dev/null
echo "Reboot for changes to reflect"
