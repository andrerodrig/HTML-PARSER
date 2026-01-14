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
    echo -e "${RED}Usage: $0 <URL>${RESET}"
    echo -e "${RED}Example: $0 https://www.example.com${RESET}"
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

    result=$(echo "$result" | cut -d " " -f 1 | awk -F "(>|&quot)" '{print $1}' | sed "s/\/\"/\"/" | sort | uniq)
    echo "$result"
}

function save_and_print() {
    local title="$1"
    local content="$2"
    local filename="$3"

    echo -e "${CYAN}$title:${RESET}"
    echo "$content"
    echo -e "${GREEN}Saving results...${RESET}"
    echo "$content" > "$site_name/$filename"
    echo -e "$sep_line"
}


matched_urls=$(process "\"https?://[^\"]+\"" "$html_content")
matched_srcs=$(process "src=\"[^\"]+\"" "$html_content")
matched_hrefs=$(process "href=\"[^\"]+\"" "$html_content")

save_and_print "Matched urls" "$matched_urls" "mached_urls.txt"
save_and_print "Matched srcs" "$matched_srcs" "mached_srcs.txt"
save_and_print "Matched hrefs" "$matched_hrefs" "mached_hrefs.txt"
