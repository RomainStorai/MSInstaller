#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

name="CMS"
tips="This script allow you to install a CMS (already done website) without any knowledges. It will install automaticaly a web server and a database. A webpage will be generated to upload your .zip file containing the CMS."

ip=$(LANG=c ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | tee /dev/tty)
if [ -z $ip ]; then
    ip=$(LANG=c ifconfig venet0:0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}' | tee /dev/tty)
fi

echo "TIPS: $tips"
echo "${GREEN}You are going to install ${WHITE}$name${GREEN}. Do you accept? ${WHITE} [Y/N]"
read answer

if [ $answer = "Y" ]; then
	echo "${BLUE}Updating packets...${WHITE}"
	apt-get update
	apt-get upgrade
	echo "${RED}Have you already installed a webserver (apache) and php5 and a mysql database? ${WHITE} [Y/N]"
	read yesno
	if [ $yesno = "N"]; then
		echo "${BLUE}Installing apache2...${WHITE}"
		apt-get install apache2
		echo "${BLUE}Installing php5...${WHITE}"
		apt-get install php5
		echo "${BLUE}Restarting apache2..${WHITE}"
		a2enmod php5
		/etc/init.d/apache2 restart
		echo "${GREEN}php5 installed!${WHITE}"
		echo "${BLUE}Installing mysql...${WHITE}"
		apt-get install mysql-server
		echo "${GREEN}mysql installed!${WHITE}"
		echo "${BLUE}Installing phpmyadmin...${WHITE}"
		apt-get install phpmyadmin
    	ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
    	apt-get install php5-mysql
    	echo "${BLUE}Restarting apache2..${WHITE}"
    	service apache2 restart
		echo "${GREEN}phpMyAdmin installed!${WHITE}"
		echo "${BLUE}Installing unzip...${WHITE}"
		apt-get install unzip
		echo "${GREEN}unzip installed!${WHITE}"
	fi
	generated=cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
	cd /var/www/html
	echo "${BLUE}Downloading uploader files...${WHITE}"
	wget -O $generated.html https://raw.githubusercontent.com/RomainStorai/MSInstaller/master/useable/downloader.html
	wget -O $generated.php https://raw.githubusercontent.com/RomainStorai/MSInstaller/master/useable/downloader.php
	echo "${GREEN}Downloaded!${WHITE}"
	echo " "
	echo " "
	echo "${RED}A link has been created in your server. Please follow the steps at ${GREEN}http://$ip/$generated.html${RED} in order to install your CMS!"
	echo "!!!DO NOT CLOSE THIS SCRIPT!!! ${BLUE}When you finished following the steps, please enter 'OK' to continue:${WHITE}"
	read ok
	rm $generated.html
	rm $generated.php
	unzip cms.zip
	rm cms.zip
	echo "${BLUE}LINK TO YOUR CMS: ${WHITE}http://$ip/"
	echo "${GREEN}INSTALLATION SUCCESSFUL! $name HAD BEEN INSTALLED.${WHITE}"
	sleep 3
	exit
else
	echo "${RED}Cancelling the installation...${WHITE}"
fi
exit