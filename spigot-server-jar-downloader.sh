#!/bin/bash

##############################################################################
# Spigot Server Jar Downloader by https://github.com/JTXOfficial
#
# Tested on Ubuntu 20.04.4
# This script is not affiliated or in any way endorsed by SpigotMC.
#
# Credit: oliver193
##############################################################################

echo "##############################################################################
# Spigot Server Jar Downloader by https://github.com/JTXOfficial
#
# Tested on Ubuntu 20.04.4
# This script is not affiliated or in any way endorsed by SpigotMC.
#
# Credit: oliver193
##############################################################################"


function download_jar {
	api="https://hub.spigotmc.org/jenkins/job"
	name="BuildTools"
	jar="BuildTools.jar"
	
	if [[ "$vr" == "1.18" ]] || [[ "$vr" == "1.18.1" ]] || [[ "$vr" == "1.18.2" ]] || [[ "$vr" == "1.19" ]] ; then
		if java -version 2>&1 >/dev/null | grep 'java version "17\|openjdk version "17' ; then
			echo "Java 17 was detected, continuing..."
		else
			echo "Java 17 isn't installed. Not having it installed won't allow it to download" $vr
			while true; do
			read -p "Would you like to download Java 17? Y|N: " yn
			
			case $yn in
				[yY] ) echo "Starting download...";
					    sudo apt install -y curl openjdk-17-jdk
						break;;
				[nN] ) echo "exiting...";
						exit;;
				* ) echo "Invalid response";
			esac
			done
		fi		
	fi
	
	if [[ "$vr" == "1.17" ]] || [[ "$vr" == "1.17.1" ]] ; then
		if java -version 2>&1 >/dev/null | grep 'java version "16\|openjdk version "16' ; then
			echo "Java 16 was detected, continuing..."
		else
			echo "Java 16 isn't installed. Not having it installed won't allow it to download" $vr
			while true; do
			read -p "Would you like to download Java 16? Y|N: " yn
			
			case $yn in
				[yY] ) echo "Starting download...";
					    sudo apt install -y curl openjdk-16-jdk
						break;;
				[nN] ) echo "exiting...";
						exit;;
				* ) echo "Invalid response";
			esac
			done
		fi		
	fi
	if [[ "$vr" == "1.16.5" ]] || [[ "$vr" == "1.16.4" ]] || [[ "$vr" == "1.16.3" ]] || [[ "$vr" == "1.16.2" ]] || [[ "$vr" == "1.16.1" ]] || [[ "$vr" == "1.15.2" ]] || [[ "$vr" == "1.15.1" ]] || [[ "$vr" == "1.15" ]] || [[ "$vr" == "1.14.4" ]] || [[ "$vr" == "1.14.3" ]] || [[ "$vr" == "1.14.2" ]] || [[ "$vr" == "1.14.1" ]]	|| [[ "$vr" == "1.14" ]] || [[ "$vr" == "1.13.2" ]] || [[ "$vr" == "1.13.1" ]] || [[ "$vr" == "1.13" ]] || [[ "$vr" == "1.12.2" ]] || [[ "$vr" == "1.12.1" ]] || [[ "$vr" == "1.12" ]] || [[ "$vr" == "1.11.2" ]] || [[ "$vr" == "1.11.1" ]] || [[ "$vr" == "1.11" ]] || [[ "$vr" == "1.10.2" ]] || [[ "$vr" == "1.9.4" ]] || [[ "$vr" == "1.9.2" ]] || [[ "$vr" == "1.9" ]] || [[ "$vr" == "1.8.8" ]] || [[ "$vr" == "1.8.3" ]] || [[ "$vr" == "1.8" ]]; then
		if java -version 2>&1 >/dev/null | grep 'java version "8\|openjdk version "8' ; then
			echo "Java 8 was detected, continuing..."
		else
			echo "Java 8 isn't installed. Not having it installed won't allow it to download" $vr
			while true; do
			read -p "Would you like to download Java 8? Y|N: " yn
			
			case $yn in
				[yY] ) echo "Starting download...";
					    sudo apt install -y curl openjdk-8-jdk
						break;;
				[nN] ) echo "exiting...";
						exit;;
				* ) echo "Invalid response";
			esac
			done
		fi		
	fi
	
	mkdir $vr
	cd $vr

	download_url="$api"/"$name"/lastSuccessfulBuild/artifact/target/"$jar"

	curl "$download_url" > $jar
	
	java -jar BuildTools.jar --rev $vr
	
	echo "Download has been completed. The jar is located in:"
	readlink -f BuildTools.jar
}


while true; do
	read -p "Which spigot version would you like from 1.8 - 1.19?: " vr
		
	case $vr in
		'1.19'* ) download_jar;;
		'1.18.2'* ) download_jar;;
		'1.18.1'* ) download_jar;;
		'1.18'* ) download_jar;;
		'1.17.1'* ) download_jar;;
		'1.17'* ) download_jar;;
		'1.16.5'* ) download_jar;;
		'1.16.4'* ) download_jar;;
		'1.16.3'* ) download_jar;;
		'1.16.2'* ) download_jar;;
		'1.16.1'* ) download_jar;;
		'1.15.2'* ) download_jar;;
		'1.15.1'* ) download_jar;;
		'1.15'* ) download_jar;;
		'1.14.4'* ) download_jar;;
		'1.14.3'* ) download_jar;;
		'1.14.2'* ) download_jar;;
		'1.14.1'* )download_jar;;
		'1.14'* ) download_jar;;
		'1.13.2'* ) download_jar;;
		'1.13.1'* ) download_jar;;
		'1.13'* ) download_jar;;
		'1.12.2'* ) download_jar;;
		'1.12.1'* ) download_jar;;
		'1.12'* ) download_jar;;
		'1.11.2'* ) download_jar;;
		'1.11.1'* ) download_jar;;
		'1.11'* ) download_jar;;
		'1.10.2'* ) download_jar;;
		'1.9.4'* ) download_jar;;
		'1.9.2'* ) download_jar;;
		'1.9'* ) download_jar;;
		'1.8.8'* ) download_jar;;
		'1.8.3'* ) download_jar;;
		'1.8'* ) download_jar;;
		
		* ) echo "Invalid version try again. 
Current Versions:
1.19
1.18.2
1.18.1
1.18
1.17.1
1.17
1.16.5
1.16.4
1.16.3
1.16.2
1.16.1
1.15.2
1.15.1
1.15
1.14.4
1.14.3
1.14.2
1.14.1
1.14
1.13.2
1.13.1
1.13
1.12.2
1.12.1
1.12
1.11.2
1.11.1
1.11
1.10.2
1.9.4
1.9.2
1.9
1.8.8
1.8.3
1.8";;
	esac
done


