#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

name="Apache 2"
echo "${GREEN}You are going to install ${WHITE}$name${GREEN}. Do you accept? ${WHITE} [Y/N]"
read answer

if [ $answer = "Y" ]; then
	echo "${BLUE}Updating packets...${WHITE}"
	apt-get update
	apt-get upgrade
	echo "${BLUE}Installing apache2...${WHITE}"
	apt-get install apache2
	echo "${RED}Do you want to install PHP5? ${WHITE} [Y/N]"
	read php5
	if [ $php5 = "Y"]; then
		echo "${BLUE}Installing php5...${WHITE}"
		apt-get install php5
		echo "${BLUE}Restarting apache2..${WHITE}"
		a2enmod php5
		/etc/init.d/apache2 restart
		echo "${GREEN}php5 installed!${WHITE}"
	fi
	echo "${RED}Do you want to install mysql? ${WHITE} [Y/N]"
	read mysqla
	if [ $mysqla = "Y"]; then
		echo "${BLUE}Installing mysql...${WHITE}"
		apt-get install mysql-server
		echo "${GREEN}mysql installed!${WHITE}"
		echo "${RED}Do you want to add phpMyAdmin? ${WHITE} [Y/N]"
		read phpmyadmin
		if [ $phpmyadmin = "Y"]; then
			echo "${BLUE}Installing phpmyadmin...${WHITE}"
			apt-get install phpmyadmin
    		ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
    		apt-get install php5-mysql
    		echo "${BLUE}Restarting apache2..${WHITE}"
    		service apache2 restart
			echo "${GREEN}phpMyAdmin installed!${WHITE}"
		fi
	fi
	echo "${GREEN}INSTALLATION SUCCESSFUL! $name HAD BEEN INSTALLED.${WHITE}"
	sleep 3
	exit
else
	echo "${RED}Cancelling the installation...${WHITE}"
fi
exit