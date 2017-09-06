pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/EventStore.sol";

contract TestMetacoin {

  function testInitialBalanceUsingDeployedContract() {
    EventStore es = EventStore(DeployedAddresses.EventStore());

  }

  function testInitialBalanceWithNewMetaCoin() {
    EventStore es = new EventStore();

//    uint expected = 10000;
//
//    Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  }

}
