
# Bugmark smart contract logger

This is a tiny logging application that allows you to log data to the blockchain via the command line.

Event logging is very low cost compared to writing contract state to the blockchain.  

# Use

Log three byte32 sized numbers to the blockchain as events:

`truffle exec commands/log_event.js 1 2 3`

Read the log from the blockchain:

`truffle exec commands/show_events.js [start_block_number]`

The optional parameter ***start_block_number*** is the block number at which to start looking for events.

# Install dependencies

## Make sure you have a recent node

We're using the 7 and 8.x series, but some earlier versions might do.

## The packages required by this module

`npm install`

## Testrpc too

`npm install -g ethereumjs-testrpc`

# Run Testrpc in it's own terminal

testrpc &

# In the /eth-es directory, compile and migrate 

truffle compile
truffle migrate

# Then log some data to the testrpc blockchain

truffle exec commands/log_event.js 1 2 3
truffle exec commands/log_event.js 4 5 6

# Then take a look at the log!

truffle exec commands/show_events.js



