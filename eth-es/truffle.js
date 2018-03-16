
module.exports = {
 networks: {
  development: {
    host: "localhost",
    port: 8545,
    network_id: "*" // match any network
  },
  live: {
    host: "23.239.13.96", // Random IP for example purposes (do not use)
    port: 80,
    network_id: 1,        // Ethereum public network
    // optional config values:
    // gas
    // gasPrice
    // from - default address to use for any transaction Truffle makes during migrations
    // provider - web3 provider instance Truffle should use to talk to the Ethereum network.
    //          - if specified, host and port are ignored.
  }
}

};
