
# Report automation

This code makes human-readable spreadsheets and text files out of blockchain data.

Prerequisites:

You need python, perl, ethabi.  An etherscan.io account is recommended.  On ubuntu, I used the rust version of ethabi from parity.

To make these reports:

1. Run download_txns.sh - that will grab the contract transactions from etherscan.io
2. Run python ./decoder.py - that will convert the downloaded json into the fields we want into human readable plain text
3. Run make_csv.sh - that will make csv files.
4. Use in your favorite spreadsheet
