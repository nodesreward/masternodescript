#!/bin/bash

PORT=49330
RPCPORT=49331
CONF_DIR=~/.nrc
COINZIP='https://github.com/nodesreward/NRC/releases/download/v1.0/nrc-linux.zip'

cd ~
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}$0 must be run as root.${NC}"
   exit 1
fi

function configure_systemd {
  cat << EOF > /etc/systemd/system/nrc.service
[Unit]
Description=Nodes Reward Coin Service
After=network.target
[Service]
User=root
Group=root
Type=forking
ExecStart=/usr/local/bin/nrcd
ExecStop=-/usr/local/bin/nrc-cli stop
Restart=always
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=10s
StartLimitInterval=120s
StartLimitBurst=5
[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  sleep 2
  systemctl enable nrc.service
  systemctl start nrc.service
}

echo ""
echo ""
DOSETUP="y"

if [ $DOSETUP = "y" ]  
then
  apt-get update
  apt install zip unzip git curl wget -y
  cd /usr/local/bin/
  wget $COINZIP
  unzip *.zip
  rm nrc-qt nrc-tx nrc-linux.zip
  chmod +x nrc*
  
  mkdir -p $CONF_DIR
  cd $CONF_DIR

fi

 IP=$(curl -s4 api.ipify.org)
 echo ""
 echo "Configure your masternodes now!"
 echo "Detecting IP address:$IP"
 echo ""
 echo "Enter masternode private key"
 read PRIVKEY
 
  echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> nrc.conf_TEMP
  echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> nrc.conf_TEMP
  echo "rpcallowip=127.0.0.1" >> nrc.conf_TEMP
  echo "rpcport=$RPCPORT" >> nrc.conf_TEMP
  echo "listen=1" >> nrc.conf_TEMP
  echo "server=1" >> nrc.conf_TEMP
  echo "daemon=1" >> nrc.conf_TEMP
  echo "maxconnections=250" >> nrc.conf_TEMP
  echo "masternode=1" >> nrc.conf_TEMP
  echo "" >> nrc.conf_TEMP
  echo "port=$PORT" >> nrc.conf_TEMP
  echo "externalip=$IP:$PORT" >> nrc.conf_TEMP
  echo "masternodeaddr=$IP:$PORT" >> nrc.conf_TEMP
  echo "masternodeprivkey=$PRIVKEY" >> nrc.conf_TEMP
  mv nrc.conf_TEMP nrc.conf
  cd
  echo ""
  echo -e "Your ip is ${GREEN}$IP:$PORT${NC}"

	## Config Systemctl
	configure_systemd
  
echo ""
echo "Commands:"
echo -e "Start Nodes Reward Coin Service: ${GREEN}systemctl start nrc${NC}"
echo -e "Check Nodes Reward Coin Status Service: ${GREEN}systemctl status nrc${NC}"
echo -e "Stop Nodes Reward Coin Service: ${GREEN}systemctl stop nrc${NC}"
echo -e "Check Masternode Status: ${GREEN}nrc-cli getmasternodestatus${NC}"

echo ""
echo -e "${GREEN}Nodes Reward Coin Masternode Installation Done${NC}"
exec bash
exit