#!/bin/bash
umask 000

# Fix a potential lack of template config
if [[ -f /usr/local/share/nzbget/nzbget.conf ]]; then
  cp /usr/local/share/nzbget/nzbget.conf /usr/local/share/nzbget/webui/
elif [[ -f /usr/local/share/nzbget/webui/nzbget.conf ]]; then
  cp /usr/local/share/nzbget/webui/nzbget.conf /usr/local/share/nzbget/
fi

# Check if nzbget.conf exists. If not, copy in the sample config
if [ -f /config/nzbget.conf ]; then
  echo "Using existing nzbget.conf file."
else
  echo "Creating nzbget.conf from template."
  cp /usr/local/share/nzbget/nzbget.conf /config/
  sed -i -e "s#\(MainDir=\).*#\1/downloads#g" /config/nzbget.conf
  sed -i -e "s#\(ControlIP=\).*#\10.0.0.0#g" /config/nzbget.conf
  sed -i -e "s#\(UMask=\).*#\1000#g" /config/nzbget.conf
  sed -i -e "s#\(ScriptDir=\).*#\1/scripts/ppscripts#g" /config/nzbget.conf
  sed -i -e "s#\(QueueDir=\).*#\1/config/queue#g" /config/nzbget.conf
  sed -i -e "s#\(LogFile=\).*#\1/config/log/nzbget.log#g" /config/nzbget.conf
  sed -i -e "s#\(SecureControl=\).*#\1yes#g" /config/nzbget.conf
  sed -i -e "s#\(SecurePort=\).*#\16791#g" /config/nzbget.conf
  sed -i -e "s#\(SecureCert=\).*#\1/config/ssl/nzbget.crt#g" /config/nzbget.conf
  sed -i -e "s#\(SecureKey=\).*#\1/config/ssl/nzbget.key#g" /config/nzbget.conf
  echo DaemonUserName=nobody >> config/nzbget.conf
  mkdir -p /downloads/dst
fi

if [[ ! -f /config/ssl/nzbget.key ]]; then
  mkdir -p /config/ssl
  openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /config/ssl/nzbget.key -out /config/ssl/nzbget.crt -subj "/O=SOHO/OU=HOME/CN=yourhome.com"
fi

# Verify and create some directories
if [[ ! -e /downloads/inter ]]; then
  mkdir -p /downloads/inter
fi

if [[ ! -e /downloads/tmp ]]; then
  mkdir -p /downloads/tmp
fi

if [[ ! -e /downloads/nzb ]]; then
  mkdir -p /downloads/nzb
fi

if [[ ! -e /config/queue ]]; then
  mkdir -p /config/queue
fi

if [[ ! -e /config/log ]]; then
  mkdir -p /config/log
fi

# Ensure permissions
chown -R nobody:users /config
chown -R nobody:users /scripts
chmod 777 /tmp

