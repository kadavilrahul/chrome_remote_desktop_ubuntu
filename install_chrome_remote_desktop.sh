#!/bin/bash

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install XFCE
sudo apt install -y xfce4 xfce4-goodies

# Install Display Manager if not installed
sudo apt install -y lightdm

# Install Chrome Remote Desktop
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
sudo dpkg -i chrome-remote-desktop_current_amd64.deb
sudo apt --fix-broken install -y
sudo apt --fix-missing install -y

# Configure Chrome Remote Desktop to use XFCE
echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" | sudo tee /etc/chrome-remote-desktop-session

# Create a new user
NEW_USER="-----------"
USER_PASSWORD="-------------"

# Add the user and set the password
sudo adduser --disabled-password --gecos "" $NEW_USER
echo "$NEW_USER:$USER_PASSWORD" | sudo chpasswd

# Add the user to the sudo group
sudo usermod -aG sudo $NEW_USER

# Create the chrome-remote-desktop group and add the user
sudo groupadd chrome-remote-desktop
sudo usermod -aG chrome-remote-desktop $NEW_USER

# Install Firefox
sudo apt install -y firefox

echo "Installation complete. Please log in as the user '$NEW_USER' to complete the Chrome Remote Desktop setup."

# Instructions for the user
echo "Log out and log in as $NEW_USER to apply the group membership changes."
echo "Install Chrome remote desktop extension on your browser"
echo "Open and go to Setup via SSH > Set up another computer > begin > next > authorize > Debian Linux > Cop aommand"
echo "Paste the command copied from chrome remote desktop and paste on the linux terminal and enter to run"
echo "Enter pin"
echo "The remote dektop connection should now be running"
