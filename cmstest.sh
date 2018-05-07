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
	if [ $yesno = "N" ]; then
		echo "${BLUE}Installing unzip...${WHITE}"
		apt-get install unzip
		echo "${GREEN}unzip installed!${WHITE}"
	fi
	generated=pwgen 1 15
	cd /var/www/html
	echo "${BLUE}Downloading uploader files...${WHITE}"
	wget -O $generated.html https://raw.githubusercontent.com/RomainStorai/MSInstaller/master/useable/downloader.html
	wget -O $generated.php https://raw.githubusercontent.com/RomainStorai/MSInstaller/master/useable/downloader.php
	echo "${GREEN}Downloaded!${WHITE}"
	echo " "
	echo " "
	echo "${RED}A link has been created in your server. Please follow the steps at ${GREEN}http://$ip/$generated.html${RED} in order to install your CMS!"
	ended_loop=true
	while $ended_loop; do
		echo "!!!DO NOT CLOSE THIS SCRIPT!!! ${BLUE}When you finished following the steps, please enter 'OK' to continue:${WHITE} ('stop' to cancel)"
		read ok
		if [ $ok = "stop" ]; then
			echo "${RED}Cancelling the installation...${WHITE}"
			rm $generated.html
			rm $generated.php
			exit
		fi
		if [ ! -fe cms.zip ]; then
			echo "You have not uploaded your CMS!"
		else
			ended_loop=false
			unzip cms.zip
			rm cms.zip
		fi
	done
	rm $generated.html
	rm $generated.php
	echo "${BLUE}LINK TO YOUR CMS: ${WHITE}http://$ip/"
	echo "${GREEN}INSTALLATION SUCCESSFUL! $name HAD BEEN INSTALLED.${WHITE}"
	sleep 3
	exit
else
	echo "${RED}Cancelling the installation...${WHITE}"
fi
exit