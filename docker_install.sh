#!/bin/bash
sudo apt update
sudo apt install -y docker.io
sudo usermod -aG docker $USER
sudo chmod 666 /var/run/docker.sock
