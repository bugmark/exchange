###############################################################################"
### Truffle 3.0, Metamask and EthereumExplorer ###"
###############################################################################"

If you're interested in building web apps with the Ethereum blockchain, you may
have found the Truffle web framework to be a nice fit for your needs.

* Truffle is the most popular development framework for Ethereum.

* MetaMask is a bridge that allows you to visit the distributed web of tomorrow
  in your browser today. It allows you to run Ethereum dApps right in your
  browser without running a full Ethereum node.

Installing Truffle Dependencies:
1/ You should have install node.js

2/ You need to install truffle (npm install -g truffle).

3/ Run a local blockchain RPC server to test, I recommend (testrpc) which you
can install it by running (npm install -g ethereumjs-testrpc)

PS:If you wanted to start up testrpc with the accounts you already have in
MetaMask, you can tell testrpc what seed phrase to use with the -m flag.

Installing Metamask:

1/You need to install Metamask from the Chrome store.
https://chrome.google.com/webstore/de...

Installing Ethereum Explorer:
https://github.com/etherparty/explorer
------------------------------------------------------------------
The default result of truffle initis a simple example currency(Metacoin).

To get it up and running, run these commands:

mkdir truffle # Create a folder for your new dapp

cd truffle # Move into that folder

truffle init webpack # Initialize a default truffle project in that folder Uses
webpack to compile the application's frontend code and move the artifacts into
the build folder.  webpack for the truffle version 3.

truffle compile # compile

truffle migrate # Build & deploy the dapp

truffle serve # Host your web interface on port 8080


We just deployed a simple alt-coin called MetaCoin to the local blockchain, and
it's available to our browser on http://localhost:8080!
