#!/bin/bash

# Target domain
#read -p "Please enter the test name : " tname
read -p "Please enter a domain name w/o http/https : " domain


# Output file names
SUBFINDER_OUTPUT="subfinder.txt"
AMASS_OUTPUT="amass.txt"
ASSETFINDER_OUTPUT="assetfinder.txt"

# Run subfinder and write output to file
sudo subfinder -d "$domain" --all -o "$SUBFINDER_OUTPUT"

# Run amass and write output to file
sudo amass enum -passive -d "$domain" > "$AMASS_OUTPUT"

# Run assetfinder and write output to file
sudo assetfinder -subs-only "$domain" > "$ASSETFINDER_OUTPUT"

# Sorts the three files and removes duplicates
sort -u subfinder.txt amass.txt assetfinder.txt > sorted.txt

shuffledns -d $domain -list sorted.txt -r /home/AMBERJACK/(stuff)/dnsvalidator/resolvers.txt -o resolved.txt

httpx -l resolved.txt -o withttp.txt