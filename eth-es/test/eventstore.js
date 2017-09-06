var EventStore = artifacts.require("./EventStore.sol");

contract('EventStore', function(accounts) {

  var instance = null; // the contract instance

  it("should put make some events.", function() {
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
        return instance.log(1, 1, 1);
    }).then(function(tx){
        return instance.log(1, 1, 2);
    }).then(function(tx){
        return instance.log(1, 1, 3);
    });
  });
});
