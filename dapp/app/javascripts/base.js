import { default as Web3 } from "web3"
import { default as contract } from 'truffle-contract'
import metacoin_artifacts from '../../build/contracts/MetaCoin.json'

var MetaCoin = contract(metacoin_artifacts);

var accounts;
var account;

// ---------------------------------------------------------------------

var base = {
  w3: function() {
    if (typeof web3 !== 'undefined') {
      console.warn("Using Truffle/MetaMask/Mist web3 provider.");
      return(web3);
    } else {
      console.warn("No web3. Falling back to http://localhost:8545.");
      var web3b = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
      return(web3b);
    }
  },
  start: function(web3) {
    var self = this;

    MetaCoin.setProvider(web3.currentProvider);

    var accs = web3.eth.accounts;
    accounts = accs;
    account  = accounts[0];
    console.log("ACC", account);
  },
  setStatus: function(message) {
    var status = document.getElementById("status");
    status.innerHTML = message;
  },
  account:  function() { return account; },
  accounts: function() { return accounts; },
  balance:  function() {
    var meta;
    return MetaCoin.deployed().then(function(instance) {
      meta = instance;
      var zz = meta.getBalance.call(account, {from: account});
      return zz;
    }).then(function(value) {
      return value.valueOf();
    }).catch(function(e) { return "Error getting balance; see log." });
  },
  htmlBalance: function(elId) {
    this.balance().then(function(value) {
      var el = document.getElementById(elId);
      el.innerHTML = value.valueOf();
    });
  },
  consoleBalance: function() {
    this.balance().then(function(value) {
      console.log("Balance:", value.valueOf());
    });
  },
  sendCoin: function() {
    var self = this;

    var amount = parseInt(document.getElementById("amount").value);
    var receiver = document.getElementById("receiver").value;

    this.setStatus("Initiating transaction... (please wait)");

    var meta;
    MetaCoin.deployed().then(function(instance) {
      meta = instance;
      return meta.sendCoin(receiver, amount, {from: account});
    }).then(function() {
      self.setStatus("Transaction complete!");
      self.refreshBalance();
    }).catch(function(e) {
      self.setStatus("Error sending coin; see log.");
    });
  }
};

// ---------------------------------------------------------------------

export default base;

