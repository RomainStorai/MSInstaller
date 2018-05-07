#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

name="phpMyAdmin"
echo "${GREEN}You are going to install ${WHITE}$name${GREEN}. Do you accept? ${WHITE} [Y/N]"
read answer

if [ $answer = "Y" ]; then
	echo "${BLUE}Updating packets...${WHITE}"
	apt-get update
	apt-get upgrade
	echo "${RED}Do you already have MySQL? ${WHITE} [Y/N]"
	read msql
	if [ $msql = "Y"]; then
		echo "${BLUE}Installing mysql...${WHITE}"
		apt-get install mysql-server
		echo "${GREEN}mysql installed!${WHITE}"
	fi
	echo "${BLUE}Installing phpmyadmin...${WHITE}"
	apt-get install phpmyadmin
	ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
	apt-get install php5-mysql
	echo "${BLUE}Restarting apache2..${WHITE}"
	service apache2 restart
	echo "${GREEN}INSTALLATION SUCCESSFUL! $name HAD BEEN INSTALLED.${WHITE}"
	sleep 3
	exit
else
	echo "${RED}Cancelling the installation...${WHITE}"
fi
exit