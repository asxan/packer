#!/bin/bash
# Install nginx in centos OS
# Created by Vitalii Klymov 13.04.2024

sudo yum -y update
sudo yum install -y epel-release
sudo yum install -y nginx
sudo systemctl start nginx