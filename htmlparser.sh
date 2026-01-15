#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[0;36m'
RESET='\033[0m'

echo -e "${RED}"
echo "  |   | __ __|   \  |  |           _ \    \      _ \    ___|   ____|   _ \  "
echo "  |   |    |    |\/ |  |          |   |  _ \    |   | \___ \   __|    |   | "
echo "  ___ |    |    |   |  |          ___/  ___ \   __ <        |  |      __ <  "
echo " _|  _|   _|   _|  _| _____|     _|   _/    _\ _| \_\ _____/  _____| _| \_\ "
echo -e "${RESET}"
                                                                     
echo -e "${YELLOW}Parsing the HTML structure from $1...${RESET}"

sep_line="${BLUE}____________________________________________________________________________${RESET}"
echo -e "$sep_line"

url="$1"
site_name=$(echo "$1" | awk -F "//(www.|)" '{print $2}' | cut -d "." -f 1)
html_content_name="$site_name.html"

# Check if the string is provided as argument
if [ "$1" == "" ]; then
    echo -e "Usage: $0 <URL>"
    echo -e "Example: $0 https://www.example.com"
    echo -e "$sep_line"
    exit 1
fi


# Save the info in a file if it's not saved yet.
if [ ! -d  "$site_name" ]; then
    html_content=$(curl -s $url)
    echo -e "${GREEN}Saving HTML...${RESET}"
    mkdir "$site_name"
    echo "$html_content" > "$site_name/$html_content_name"
    echo -e "$sep_line"

fi

html_content="./$site_name/$html_content_name"


function process() {
    local pattern="$1"
    local file="$2"

    local result=$(grep -oE "$pattern" "$file")

    result=$(
        echo "$result" | cut -d " " -f 1 | awk -F "(>|&quot)" '{print $1}' |\
        cut -d "\"" -f 2 | sed "s/\/$//g" | sort | uniq
    )
    echo "$result"
}

function save_and_print() {
    local title="$1"
    local content="$2"
    local filename="$3"

    echo -e "${CYAN}$title:${RESET} $(echo "$content" | wc -l) results found."
    echo "$content" > "$site_name/$filename"
}


found_urls=$(process "https?://[^\"]+" "$html_content")
found_srcs=$(process "src=\"[^\"]+\"" "$html_content")
found_hrefs=$(process "href=\"[^\"]+\"" "$html_content")

found_dnses=$(echo "$found_urls" | awk -F "//" '{print $2}' | awk -F "(/|?)" '{print $1}' | sort | uniq)
found_ips=$(
    for domain in $(echo "$found_dnses"); do
        host $domain;
    done
)

found_ipv4=$(echo "$found_ips" | grep -oEi "([0-9]{1,3}\.){3}[0-9]{1,3}")
found_ipv6=$(echo "$found_ips" | grep -oEi "([0-9a-f]{1,4}::?){2,7}[0-9a-f]{0,4}")
found_servers=$(echo "$found_ips" | grep -oE "handled by [0-9]+ [a-zA-Z0-9.-]+" | awk '{print $4}')


save_and_print "URLs" "$found_urls" "found_urls.txt"
save_and_print "srcs" "$found_srcs" "found_srcs.txt"
save_and_print "hrefs" "$found_hrefs" "found_hrefs.txt"
save_and_print "DNSes" "$found_dnses" "found_dnses.txt"
save_and_print "IPv4" "$found_ipv4" "found_ipv4.txt"
save_and_print "IPv6" "$found_ipv6" "found_ipv6.txt"
save_and_print "Servers" "$found_servers" "found_servers.txt"

echo -e "$sep_line"
echo -e "${GREEN}Results saved in:${RESET} $site_name/"

