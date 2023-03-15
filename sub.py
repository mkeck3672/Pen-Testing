import os
import subprocess

# Target domain
target = "example.com"

# Output file
output_file = "subdomains.txt"

# Run subfinder and append output to file
subfinder_output = subprocess.check_output(["subfinder", "-d", target])
with open(output_file, "ab") as f:
    f.write(subfinder_output)

# Run amass and append output to file
amass_output = subprocess.check_output(["amass", "enum", "-d", target])
with open(output_file, "ab") as f:
    f.write(amass_output)

# Run assetfinder and append output to file
assetfinder_output = subprocess.check_output(["assetfinder", target])
with open(output_file, "ab") as f:
    f.write(assetfinder_output)

# Sort and deduplicate the output file
with open(output_file, "r") as f:
    subdomains = sorted(set(f.readlines()))

with open(output_file, "w") as f:
    f.write("".join(subdomains))
