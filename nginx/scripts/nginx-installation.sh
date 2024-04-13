#!/bin/bash
# Install nginx in centos OS
# Created by Vitalii Klymov 13.04.2024

sudo yum -y update
sudo yum install -y epel-release
echo "Install nginx"
sudo yum install -y nginx
echo "Start nginx"
sudo systemctl start nginx
echo "Enable nginx to start after the system started"
sudo systemctl enable nginx