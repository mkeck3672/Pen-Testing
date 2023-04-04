#!/bin/bash

read -p "Please enter your file name w/ http/https : " file

# Output file names
katana="katana.txt"
wayback="wayback.txt"
gau="gau.txt"
#hakrawler="hakrawler.txt"
#feroxbuster="ferox.txt"

# Run katana and write output to file
cat $file | katana -d 8 -kf all -fs fqdn -o -ef tiff,tif2,woff,woff2,jpg,png,gif $katana

# Run gau and write output to fileffuf
cat $file | gau --threads 30 --blacklist tiff,tif2,woff,woff2,jpg,png,gif | tee $gau

# Run wayback and write output to file
cat $file | waybackurls | tee $wayback

# Run hakrawler and write output to file
#cat $file | hakrawler -d 10 -subs | tee hakrawler

# Run feroxbuster and write output to file
#cat $file | ./feroxbuster -e 

# Sorts the three files and removes duplicates
sort -u katana.txt wayback.txt gau.txt > sub_sorted.txt