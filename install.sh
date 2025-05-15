#!/bin/bash

echo "root:welcome" | chpasswd

apt update

apt install -y ansible

pwd

PLAYBOOK_DIR="./golf-kubernetes/ansible"

cd $PLAYBOOK_DIR

ansible-playbook golf_playbook.yaml -u golf 

