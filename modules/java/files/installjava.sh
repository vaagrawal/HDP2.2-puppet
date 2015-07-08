#!/bin/sh
 mkdir /usr/java
cd /usr/java/
 wget https://dl.dropboxusercontent.com/u/32400638/java/jdk/jdk-7u79-linux-x64.tar.gz
 tar -zxvf jdk-7u79-linux-x64.tar.gz
 ln -s jdk1.7.0_79/  default
 echo 'export JAVA_HOME=/usr/java/default' >> /root/.bash_profile
 echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /root/.bash_profile
 source ~/.bash_profile
