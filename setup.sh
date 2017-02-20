#!/bin/sh
############################################
echo "PYCASTER Installer"
echo "System Update and Upgrade... \n"
sudo apt-get update
sudo apt-get upgrade

echo "Installing requirements... \n"
sudo apt-get install python-dev python-pip nodejs npm lame mpg321 mplayer omxplayer git -y

echo "Updating youtube-dl"
sudo apt-get remove youtube-dl -y
sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
youtube-dl -U

sleep 2
echo "I'm going to install H264 Support now, this WILL take some time!!!"
sleep 3

# We need to get H264 Support & FFMPEG on the system... Repo won't have it...

# H264 Process...
cd /usr/src
sudo rm -r x264 ffmpeg  #make a fresh install
sudo git clone git://git.videolan.org/x264
cd x264
sudo ./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
sudo make
sudo make install

echo "Installing FFMPEG - This might take a while !"
sleep 3

# Process for FFMPEG...
cd /usr/src # We could have done cd.. but we're taking NO CHANCES...
sudo git clone git://source.ffmpeg.org/ffmpeg.git
cd ffmpeg
sudo ./configure --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree
sudo make
sudo make install

# Install FOREVER to keep PYCASTER running ; EXPRESS AND SOCKET for server/client communication
sudo npm install forever -g
sudo npm install forever-monitor -g
sudo npm install express
sudo npm install socket.io

# GET PYCASTER FILES
echo "Creating PYCASTER directory and getting files\n"
cd ~
mkdir PYCASTER
cd PYCASTER

sleep 1
wget https://raw.githubusercontent.com/DevonLian/PYCASTER/master/server.js
wget https://raw.githubusercontent.com/DevonLian/PYCASTER/master/index.html
wget https://raw.githubusercontent.com/DevonLian/PYCASTER/master/pycaster.sh

#Setting permissions
sudo chmod 755 pycaster.sh server.js index.html

echo "INSTALLATION COMPLETE\n"
sleep 1
echo "Launching PYCASTER..."
pycaster.sh start
echo "Contribute to Free and Open Source Software, learn, hack and live!"
sleep 1
