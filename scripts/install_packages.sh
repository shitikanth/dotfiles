#!/bin/bash
# Script for installing commonly used packages.

if [ -f /etc/lsb-release ]
then
    SYNC_CMD="sudo apt update"
    INSTALL_CMD="sudo apt install -y"
elif [ -f /etc/redhat-release ]
then
    SYNC_CMD="sudo dnf update"
    INSTALL_CMD="sudo dnf install -y"
fi


# Print usage
usage () {
    echo "install_packages.sh"
}

# Parse command line arguments
while [ "$1" != "" ]; do
    case $1 in
        -n | --dry-run )	DRY_RUN=1
                                ;;
        -h | --help )		usage
                                exit
                                ;;
        * )			usage
                                exit 1
    esac
    shift
done

if [ $DRY_RUN ]; then
    echo "--> dry run <--"
    SYNC_CMD="echo $SYNC_CMD"
    INSTALL_CMD="echo $INSTALL_CMD"
fi

# Build packages list
PACKAGES=(
    gcc
    gdb
    vim
    emacs
    git
    rofi
    feh
    caja
    #caja-dropbox
    lxpanel
    lxappearance
    subversion
    mercurial
    cmake
    w3m
    htop
    breeze-icon-theme
)

$SYNC_CMD
$INSTALL_CMD ${PACKAGES[@]}
