# HTML Parser

A Bash script designed to download HTML content from a specified URL and parse it to extract URLs, `src` attributes, and `href` attributes. The results are organized and saved into a dedicated directory for the target site.

## Features

- **HTML Downloader**: Fetches the raw HTML.
- **Attribute Extraction**: Parses the HTML to identify and extract:
  - Full URLs (`http` and `https` patterns).
  - Source attributes (`src="..."`).
  - Hyperlink references (`href="..."`).

A directory is created, based on the target domain to store the downloaded HTML and extracted lists.

## Installation

1. Download the `htmlparser.sh` script.
2. Grant execution permissions to the script:

   ```bash
   chmod +x htmlparser.sh
   ```

