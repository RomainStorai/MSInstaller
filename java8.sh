#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

name="Java 8"
echo "${GREEN}You are going to install ${WHITE}$name${GREEN}. Do you accept? ${WHITE} [Y/N]"
read answer

if [ $answer = "Y" ]; then
	echo "${BLUE}Updating packets...${WHITE}"
	apt-get update
	apt-get upgrade
	echo "${BLUE}Adding java 8 packets...${WHITE}"
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
    echo "${BLUE}Update ine more time...${WHITE}"
	apt-get update
	apt-get upgrade
	echo "${BLUE}Installing java 8...${WHITE}"
	apt-get install oracle-java8-installer
	echo "${GREEN}THE INSTALLATION SUCCEEDED! $name HAD BEEN INSTALLED.${WHITE}"
	sleep 3
	exit
fi
exit