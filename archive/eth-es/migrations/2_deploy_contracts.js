var EventStore = artifacts.require("./EventStore.sol");

module.exports = function(deployer) {
  deployer.deploy(EventStore);
};
