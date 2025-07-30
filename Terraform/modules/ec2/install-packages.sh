#!/bin/bash
apt update
apt install openjdk-17-jdk -y
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
                        https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
                        echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
                        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                        /etc/apt/sources.list.d/jenkins.list > /dev/null
                        apt update
                        apt install jenkins -y
snap install aws-cli --classic
apt install maven -y
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
apt install -y /tmp/google-chrome-stable_current_amd64.deb
