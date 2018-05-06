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
			echo "${BLUE}Downloading script ${WHITE}$1${BLUE}..."
			wget -q https://raw.githubusercontent.com/RomainStorai/MSInstaller/12e6f9206637a45216747af2c01f0144b128876c/$1.sh
			if [ ! -f $1.sh ]; then
				clear_console
				echo "${RED}Download failed!${WHITE}"
			else
				clear_console
				echo "${GREEN}Downloaded!${WHITE}"
				chmod 744 $1.sh
				echo "${BLUE}Launching script!${WHITE}"
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
	echo "-------------"
	echo "Main Scripts Installer"
	echo "by Romain"
	echo "-------------"

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

while true; do
	clear_console
	echo "${BLUE}Which service do you want to install?${WHITE} (type 'list' to see all the scripts)"
	read answer

	if [ $answer = "list" ]; then
		clear_console
		echo "${GREEN}Available scripts on your device:${WHITE}"
		echo ".... Coming soon ...."
		read answer
		
		elif [ $answer = "exit" ]; then
			clear
			exit

		else
			install_script $answer
			read answer
	fi

done
