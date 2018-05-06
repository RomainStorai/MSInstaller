#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

check_downloader () {
	if [ ! -x /usr/bin/wget ]; then
		echo "${BLUE}WGET is not installed in your server! Processing installation..."
		echo "${GREEN}Updating packets...${WHITE}"
		apt-get update
		apt-get upgrade
		echo "${GREEN}Downloading wget...${WHITE}"
		apt-get install wget -y
		echo "${GREEN}WGET's INSTALLATION SUCCEDED!${WHITE}"
	fi
}

install_script () {
	if [ ! -z "$1" ]; then
		echo " "
		if [ ! -f $1.sh ]; then
			echo "${BLUE}Preparing download of the script for ${WHITE}$1${BLUE}..."
			wget -q https://raw.githubusercontent.com/RomainStorai/MSInstaller/master/$1.sh
			if [ ! -f $1.sh ]; then
				clear_console
				echo "${RED}Unknown script!${WHITE}"
			else
				clear_console
				echo "${GREEN}Downloaded!${WHITE}"
				chmod 744 $1.sh
				echo "${BLUE}Launching the script!${WHITE}"
				echo " "
				./$1.sh
			fi
		else
			clear_console
			echo "${GREEN}Script already installed!${WHITE}"
				chmod 744 $1.sh
				echo "${BLUE}Launching script!${WHITE}"
				echo " "
				./$1.sh
		fi
	fi
}

clear_console () {
	clear
	echo " "
	echo "${GREEN}MainScriptsInstaller${WHITE}"
	echo "Easier and faster installations."
	echo "by RomainStorai"
	echo " "

	for i in $(seq 1 3);
	do
	    echo " "
	done
}

clear_console

if [ $(id -u) != 0 ]; then
    echo "${RED}This script must be launched as root!${WHITE}"
    exit
fi

if [ ! -d scripts ]; then
	mkdir scripts
	chmod 744 scripts
fi
cd scripts

check_downloader

wget -O list.txt https://raw.githubusercontent.com/RomainStorai/MSInstaller/master/list.txt

while true; do
	clear_console
	echo "${BLUE}Which service do you want to install?${WHITE} (type 'list' to see all the scripts)"
	read answer

	if [ $answer = "list" ]; then
		clear_console
		echo "${GREEN}Available scripts on your device:${WHITE}"
		while read line
		do 
			echo "	- $line" 
		done < list.txt

		read answer
		
		elif [ $answer = "exit" ]; then
			clear
			exit

		elif [ ! -z "$answer" -a "$answer" != " " ]; then
			install_script $answer
			read answer
	fi

done
