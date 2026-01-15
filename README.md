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
git clone https://github.com/andrerodrig/HTML-PARSER.git
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