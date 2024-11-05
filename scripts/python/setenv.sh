#!/bin/bash

# Prepare Python for Debian 12 Bookworm (from jenkins/jenkins:lts-jdk17@sha256:7ea4989040ce0840129937b339bf8c8f878c14b08991def312bdf51ca05aa358)
OS_RELEASE=$(grep "VERSION=\"12 (bookworm)\"" /etc/os-release)

if [[ $OS_RELEASE == "VERSION=\"12 (bookworm)\"" ]]; then
    sudo apt-get install --no-install-recommends -y python3=3.11.2-1+b1 python3-pip=23.0.1+dfsg-1 python3-venv=3.11.2-1+b1
fi

# Create a virtual environment
python3 -m venv jenkins_venv

# Activate the environment
source jenkins_venv/bin/activate

# Install required modules
pip install -r requirements.txt

# Load the job inside Jenkins
python create_job.py