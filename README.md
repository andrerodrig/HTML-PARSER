# HTML Parser

A Bash script designed to download HTML content from a specified URL and parse it to extract URLs, `src` attributes, and `href` attributes. The results are organized and saved into a dedicated directory for the target site.

## Features

- **HTML Downloader**: Fetches the raw HTML.
- **Attribute Extraction**: Parses the HTML to identify and extract:
  - Full URLs (`http` and `https` patterns).
  - Source attributes (`src="..."`).
  - Hyperlink references (`href="..."`).
  - Found DNS list.
  - IP Addresses (IPv4 and IPv6).

A directory is created, based on the target domain to store the downloaded HTML and extracted lists.

## Installation

```bash
git clone https://github.com/andrerodrig/htmlparser.git
cd htmlparser
```

Install with `./install.sh`:

```bash
chmod +x install.sh
./install.sh
```

## Uninstall

```bash
chmod +x uninstall.sh
./uninstall.sh
```

## Usage

```
htmlparser <URL>
```

**Example**:

```bash
htmlparser https://www.google.com
```

This will create a directory named `google` in the current working directory, containing:

- `google.html`: The downloaded HTML content.
- `found_urls.txt`: A list of all extracted URLs.
- `found_srcs.txt`: A list of all extracted `src` attributes.
- `found_hrefs.txt`: A list of all extracted `href` attributes.
- `found_dnses.txt`: A list of all found DNS entries.
- `found_ipv4.txt`: A list of all found IP addresses.
- `found_ipv6.txt`: A list of all found IP addresses.
- `found_servers.txt`: Some other servers found.
