#!/bin/sh

RED='\033[0;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
WHITE='\033[0m'

name="Minecraft Server"
tips="You must have java installed on your server to launch a minecraft server!"

echo "Tips: $tips"
echo "${GREEN}You are going to install ${WHITE}$name${GREEN}. Do you accept? ${WHITE} [Y/N]"
read answer

if [ $answer = "Y" ]; then
	echo "${RED}Where do you want to install the server?${WHITE} (/home/minecraftserver)"
	read path
	mkdir $path
	cd $path
	echo "${RED}If you want a custom jar, enter the link bellow. If you just need the base server type 'enter'!${WHITE}"
	read jarfile
	if [ ! -z "$jarfile" -a "$jarfile" != " " ]; then
		echo "${BLUE}Downloading custom jarfile...${WHITE}"
		wget -O server.jar $jarfile
	else
		echo "${BLUE}Downloading server...${WHITE}"
		wget -O server.jar https://yivesmirror.com/grab/spigot/spigot-latest.jar
	fi
	touch eula.txt
    echo "eula=true" >> eula.txt
    touch start.sh
    echo "java -Xms512M -jar server.jar" >> start.sh
    chmod +x start.sh
    echo "${RED}HOW TO START THE SERVER? Just run start.sh in the directory of the server!"
	echo "${GREEN}INSTALLATION SUCCESSFUL! $name HAD BEEN INSTALLED.${WHITE}"
	sleep 3
	exit
else
	echo "${RED}Cancelling the installation...${WHITE}"
fi
exit