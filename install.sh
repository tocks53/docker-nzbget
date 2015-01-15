#!/bin/bash

add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe multiverse"
add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates universe multiverse"
add-apt-repository ppa:mc3man/trusty-media

apt-get update -qq
apt-get install -qy build-essential \
                    pkg-config \
                    libxml2-dev \
                    libncurses5-dev \
                    libsigc++-2.0-dev \
                    libpar2-dev \
                    libssl-dev \
                    sgml-base \
                    xml-core \
                    javascript-common \
                    libjs-jquery \
                    libjs-jquery-metadata \
                    libjs-jquery-tablesorter \
                    libjs-twitter-bootstrap \
                    libpython-stdlib \
                    python \
                    ffmpeg \
                    wget \
                    unrar \
                    unzip \
                    p7zip

apt-get clean -y
rm -rf /var/lib/apt/lists/* /var/cache/* /var/tmp/*

tar xf /tmp/nzbget.tar.gz && \
    rm /tmp/nzbget.tar.gz && \
    cd /nzbget-$VERSION && \
    ./configure && \
    make && \
    make install && \
    rm -rf /nzbget-$VERSION

# Add some post-processing scripts
# nzbToMedia
mkdir -p /scripts/ppscripts/nzbToMedia
wget -nv https://github.com/clinton-hall/nzbToMedia/archive/master.tar.gz -O - | tar --strip-components 1 -C /scripts/ppscripts/nzbToMedia -zxf -

# Videosort
mkdir -p /scripts/ppscripts/videosort
wget -nv http://sourceforge.net/projects/nzbget/files/ppscripts/videosort/videosort-ppscript-5.0.zip/download -O /scripts/ppscripts/videosort-ppscript-5.0.zip
unzip -qq /scripts/ppscripts/videosort-ppscript-5.0.zip -d /scripts/ppscripts
rm /scripts/ppscripts/videosort-ppscript-5.0.zip

# NotifyXBMC.py
wget -nv http://nzbget.net/forum/download/file.php?id=193 -O /scripts/ppscripts/NotifyXBMC.py

