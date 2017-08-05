module.exports = function(done) {
    var mvsc = MvscMarket.deployed();
    var repo_url = process.argv[4];

    mvsc.setRepoUrl(repo_url).then(function(tx){
	    var data = {'tx':tx, 'old':repo_url, 'new':new_repo_url}

	console.log(JSON.stringify(data));
	done();
    });
};
