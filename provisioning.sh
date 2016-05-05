#!/bin/bash
# -*- mode: bash -*-
# vi: set ft=bash :

sudo apt-get update

echo "Installing common items and ansible dependencies"
sudo apt-get install curl unzip software-properties-common python-dev python-setuptools -y
sudo easy_install pip

echo "Installing ansible"
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y

echo "Installing ansible dependencies"
/usr/local/bin/pip install git+git://github.com/openstack/python-novaclient
/usr/local/bin/pip install docker-py
/usr/local/bin/pip install pyrax