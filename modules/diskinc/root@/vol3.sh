#!/bin/bash

DNAME=$( lsblk | grep disk | awk '{print $1}')
CDN=/dev/$DNAME

DSTART=$(sudo parted /dev/vda p | grep lvm| awk '{print $3}')

DEND=$(sudo fdisk -l | grep Disk | grep GB | awk '{print $3}')
TEMP="GB"
DEND=$DEND$TEMP

VOLFULL=$(lsblk | grep dm | sed '/SWAP/d' |  awk '{print $2}')
IFS='-' read -ra ADDR <<< "$VOLFULL"

LOGVOL=${ADDR[1]}

VOLGR=$(sudo vgdisplay | awk '{print $3}' | awk 'NR==2')
DEVV=/dev/

CDNAME=/dev/$DNAME

TEMP="3"
NEWPV=$CDNAME$TEMP

echo "Creating partition"
sudo pvcreate $NEWPV
echo "Extending volume group"
sudo vgextend $DEVV$VOLGR $NEWPV
echo "Extending logical volume"
TEMP="/"
sudo lvextend $DEVV$VOLGR$TEMP$LOGVOL $NEWPV

echo "Resizing"
sudo resize2fs $DEVV$VOLGR$TEMP$LOGVOL

