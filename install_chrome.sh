#!/bin/bash

# From https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-20-04/
sudo apt update -y
sudo apt install wget -y

mkdir -p ~/Dev
cd ~/Dev
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo apt install ./google-chrome-stable_current_amd64.deb -y

rm *.deb
