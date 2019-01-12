var EventStore = artifacts.require("./EventStore.sol");

contract('EventStore', function(accounts) {

  var instance = null; // the contract instance

  it("should log some events.", function() {
    return EventStore.deployed().then(function(_instance) {
        // lets do an event!
        instance = _instance;
        var transfers = instance.GenericEvent({fromBlock: 0});
        transfers.watch(function (error, result) {
            // This will catch all Transfer events, regardless of how they originated.
            if (error == null) {
                console.log('EVENT!');
                console.log(result.args);
            }
        });
        return instance.log(1, 12341234123514523452345);
    }).then(function(tx){
        return instance.log(1, "now is the time for all good men to come to the aid of the party");
    }).then(function(tx){
        return instance.log(1, '0xea906d728c144f2192ea0d8fd14ad6a2be051ca7b2da921903cb157d735a9412');
    });
  });
});
