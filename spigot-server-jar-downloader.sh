#!/bin/bash

##############################################################################
# Spigot Server Jar Downloader by https://github.com/JTXOfficial
# Updated and optimized version
#
# Tested on Ubuntu 20.04.4 and higher
# This script is not affiliated or in any way endorsed by SpigotMC.
#
# Credit: oliver193, with updates by Claude
##############################################################################

echo "##############################################################################
# Spigot Server Jar Downloader
#
# This script is not affiliated or in any way endorsed by SpigotMC.
##############################################################################"

# Define version ranges and their required Java version
declare -A java_requirements=(
    ["1.8-1.16.5"]=8
    ["1.17-1.17.1"]=16
    ["1.18-1.20.5"]=17
    ["1.21-latest"]=21
)

# Supported versions array (newest first)
versions=(
    "1.21.1" "1.21"
    "1.20.6" "1.20.5" "1.20.4" "1.20.3" "1.20.2" "1.20.1" "1.20"
    "1.19.4" "1.19.3" "1.19.2" "1.19.1" "1.19"
    "1.18.2" "1.18.1" "1.18"
    "1.17.1" "1.17"
    "1.16.5" "1.16.4" "1.16.3" "1.16.2" "1.16.1" "1.16"
    "1.15.2" "1.15.1" "1.15"
    "1.14.4" "1.14.3" "1.14.2" "1.14.1" "1.14"
    "1.13.2" "1.13.1" "1.13"
    "1.12.2" "1.12.1" "1.12"
    "1.11.2" "1.11.1" "1.11"
    "1.10.2" "1.10"
    "1.9.4" "1.9.2" "1.9"
    "1.8.8" "1.8.3" "1.8"
)

function check_java_version() {
    local required_version=$1
    
    if java -version 2>&1 | grep -q "version \"$required_version\|openjdk version \"$required_version"; then
        return 0
    else
        return 1
    fi
}

function install_java() {
    local version=$1
    
    echo "Java $version isn't installed. Required for Minecraft version $vr"
    read -p "Would you like to download Java $version? [Y/n]: " yn
    
    case ${yn:-y} in
        [yY]* ) 
            echo "Starting download..."
            sudo apt update
            sudo apt install -y curl openjdk-$version-jdk
            return 0;;
        * ) 
            echo "Exiting..."
            return 1;;
    esac
}

function get_required_java() {
    local mc_version=$1
    
    for range in "${!java_requirements[@]}"; do
        IFS=- read min max <<< "$range"
        
        # Handle "latest" as a special case
        if [[ "$max" == "latest" ]]; then
            if [[ "$(echo -e "$mc_version\n$min" | sort -V | tail -n1)" == "$mc_version" ]]; then
                echo "${java_requirements[$range]}"
                return
            fi
        else
            if [[ "$(echo -e "$mc_version\n$min" | sort -V | tail -n1)" == "$mc_version" && 
                  "$(echo -e "$mc_version\n$max" | sort -V | head -n1)" == "$mc_version" ]]; then
                echo "${java_requirements[$range]}"
                return
            fi
        fi
    done
    
    # Default to Java 17 if no match found
    echo "17"
}

function download_jar() {
    local java_version=$(get_required_java "$vr")
    
    # Check if required Java is installed
    if ! check_java_version "$java_version"; then
        if ! install_java "$java_version"; then
            return 1
        fi
    else
        echo "Java $java_version was detected, continuing..."
    fi
    
    # Create directory and download BuildTools
    mkdir -p "$vr"
    cd "$vr"
    
    local api="https://hub.spigotmc.org/jenkins/job"
    local name="BuildTools"
    local jar="BuildTools.jar"
    local download_url="$api/$name/lastSuccessfulBuild/artifact/target/$jar"
    
    echo "Downloading BuildTools.jar..."
    curl -s "$download_url" > "$jar"
    
    echo "Building Spigot $vr (this may take a while)..."
    java -jar BuildTools.jar --rev "$vr"
    
    echo "Download and build complete! The server jar is located at:"
    find "$(pwd)" -name "spigot-$vr*.jar" | head -n1
    
    # Return to original directory
    cd ..
}

# Display available versions in a grid format
function display_versions() {
    echo "Available Minecraft versions:"
    echo "--------------------------"
    
    local cols=5
    local count=0
    
    for v in "${versions[@]}"; do
        printf "%-10s" "$v"
        ((count++))
        
        if ((count % cols == 0)); then
            echo ""
        fi
    done
    
    # Print final newline if needed
    if ((count % cols != 0)); then
        echo ""
    fi
    
    echo "--------------------------"
}

# Main execution
display_versions

while true; do
    read -p "Which Spigot version would you like to download? " vr
    
    # Check if version is supported
    if [[ " ${versions[*]} " == *" $vr "* ]]; then
        download_jar
        break
    else
        echo "Invalid or unsupported version: $vr"
        read -p "Display available versions? [Y/n]: " show_versions
        
        case ${show_versions:-y} in
            [yY]* ) display_versions;;
            * ) ;;
        esac
    fi
done

echo "Thank you for using the Spigot Server Jar Downloader!"
