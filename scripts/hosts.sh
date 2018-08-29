#!/bin/bash
# Replaces /etc/hosts with hosts file downloaded from https://github.com/StevenBlack/hosts

HOSTS_URL="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts"
HOSTS_FILE=/etc/hosts
TEMP_FILE=$(mktemp)

wget $HOSTS_URL -O $TEMP_FILE
sudo cp --backup=numbered $TEMP_FILE $HOSTS_FILE
