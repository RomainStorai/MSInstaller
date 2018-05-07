#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

name="php5"
echo "${GREEN}You are going to install ${WHITE}$name${GREEN}. Do you accept? ${WHITE} [Y/N]"
read answer

if [ $answer = "Y" ]; then
	echo "${BLUE}Updating packets...${WHITE}"
	apt-get update
	apt-get upgrade
	echo "${RED}Do you already have apache2? ${WHITE} [Y/N]"
	read apache
	if [ $apache = "Y" ]; then
		echo "${BLUE}Installing apache2...${WHITE}"
		apt-get install apache2
		echo "${GREEN}apache2 installed!${WHITE}"
	fi
	echo "${BLUE}Installing php5...${WHITE}"
	apt-get install php5
	echo "${BLUE}Restarting apache2..${WHITE}"
	a2enmod php5
	/etc/init.d/apache2 restart
	echo "${GREEN}INSTALLATION SUCCESSFUL! $name HAD BEEN INSTALLED.${WHITE}"
	sleep 3
	exit
else
	echo "${RED}Cancelling the installation...${WHITE}"
fi
exit