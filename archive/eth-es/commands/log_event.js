var EventStore = artifacts.require("./EventStore.sol");

// log an event!
module.exports = function(done) {
    var es = null;
    EventStore.deployed().then(function(store){
	es = store;
	console.log(store);
    var id1 = process.argv[4];
    var string1 = process.argv[5];

    if (id1 && string1) {
        es.log(id1,string1).then(function(tx){
            console.log(JSON.stringify({
                'result':'log','id1':id1,'string1':string1
            }));
            done();
        });
    } else {
        console.log('Logging Failed');
	    done();
    }

	done();
    });
};
