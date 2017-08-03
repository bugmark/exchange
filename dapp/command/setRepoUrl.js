module.exports = function(done) {
    var mvsc = MvscMarket.deployed();

    mvsc.getRepoUrl().then(function(tx){
	    var data = {'tx':tx, 'url':url}

	console.log(JSON.stringify(data));
	done();
    });
};
