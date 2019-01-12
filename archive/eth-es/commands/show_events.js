module.exports = function(done) {
    var startBlock = parseInt(process.argv[4]);
    if (!startBlock) startBlock = 0;
    
    var EventStore = artifacts.require("./EventStore.sol");
    EventStore.deployed().then(function(es){
	es.contract.GenericEvent({},{fromBlock: startBlock, toBlock: 'latest'}).get(function(error,result){
	    if (error == null) {
		for(i=0; i < result.length; i++) {
		    var r = result[i];
		    console.log(JSON.stringify([r.blockNumber, r.event, r.args.id1, r.args.id2, r.args.id3]));
		}
	    } else {
	    }
	    done();
	});
    });
};
