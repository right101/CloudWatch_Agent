#!/bin/bash

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Your system is not supported by this script."
    exit 1
fi

# Install AWS CLI based on the detected distribution
case $DISTRO in
    

    "ubuntu")
        sudo apt-get update
        sudo apt-get install awscli -y
        ;; 

    
    *)
        echo "Your system ($DISTRO) is not supported by this script."
        exit 1
        ;;
esac

# Verify installation
if command -v aws &> /dev/null; then
    echo "AWS CLI installed successfully!"
    aws --version
else
    echo "AWS CLI installation failed."
    exit 1
fi
