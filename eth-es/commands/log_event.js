var EventStore = artifacts.require("./EventStore.sol");


// log an event!
module.exports = function(done) {
    var es = null;
    EventStore.deployed().then(function(store){
	es = store;
	console.log(store);
    var id1 = process.argv[4];
    var id2 = process.argv[5];
    var id3 = process.argv[6];

    if (id1 && id2 && id3) {
        es.log(id1,id2,id3).then(function(tx){
            console.log(JSON.stringify({
                'result':'log','id1':id1,'id2':id2,'id3':id3
            }));
            done();
        });
    } else {
        console.log('nope');
	    done();
    }


	done();
    });
};
