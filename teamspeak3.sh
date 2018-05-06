#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

name="Teamspeak 3 Server"

echo "${GREEN}You are going to install ${WHITE}$name${GREEN}. Do you accept? ${WHITE} [Y/N]"
read answer

if [ $answer = "Y" ]; then
	echo "${RED}Where do you want to install the server?${WHITE} (/home/teamspeakserver)"
	read path
	mkdir $path
	cd /home
	echo "${BLUE}Downloading server...${WHITE}"
	wget http://dl.4players.de/ts/releases/3.0.10.3/teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
	echo "${BLUE}Unzipping...${WHITE}"
    tar -xvzf teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
    rm teamspeak3-server_linux-amd64-3.0.10.3.tar.gz
    echo "${BLUE}Moving teamspeakserver to the path...${WHITE}"
    mv teamspeak3-server_linux-amd64 $path
    cd $path
    chmod +x ts3server_startscript.sh
    echo "${RED}HOW TO START THE SERVER? Just run ts3server_startscript.sh in the directory of the server!"
	echo "${GREEN}INSTALLATION SUCCESSFUL! $name HAD BEEN INSTALLED.${WHITE}"
	sleep 3
	exit
else
	echo "${RED}Cancelling the installation...${WHITE}"
fi
exit