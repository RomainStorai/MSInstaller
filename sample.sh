#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

echo "${GREEN}You are going to install ${WHITE}TEST${GREEN}. Do you accept? ${WHITE} [Y/N]"
read answer

if [ $answer = "Y" ]; then
	echo "${BLUE}Updating packets...${WHITE}"
	apt-get update
	apt-get upgrade

	echo "${GREEN}THE INSTALLATION SUCCEEDED! TEST HAS BEEN INSTALL.${WHITE}"
	sleep 3
	exit
fi
exit