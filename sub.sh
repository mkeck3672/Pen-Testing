#!/bin/bash

# Target domain
TARGET="synack.com"

# Output file names
SUBFINDER_OUTPUT="subfinder.txt"
AMASS_OUTPUT="amass.txt"
ASSETFINDER_OUTPUT="assetfinder.txt"

# Run subfinder and write output to file
sudo subfinder -d "$TARGET" --all -o "$SUBFINDER_OUTPUT"

# Run amass and write output to file
sudo amass enum -passive -d "$TARGET" > "$AMASS_OUTPUT"

# Run assetfinder and write output to file
sudo assetfinder -subs-only "$TARGET" > "$ASSETFINDER_OUTPUT"

sort -u subfinder.txt amass.txt assetfinder.txt > domain.txt
