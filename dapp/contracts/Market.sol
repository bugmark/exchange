pragma solidity ^0.4.11;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";



contract Market is Ownable {

    // Public Data //
	string public repo_url;

	// Contract Data //

    // Tracks status of reward contracts -  will not compile if you terminate the next line in semicolon
	enum rewardState { incomplete, posted, countered, won_publisher, won_counterparty, expired }

	struct Reward {
		address publisher;
		address counterParty;
		uint rewardAmount; // Wei
		uint issueNumber; // number
		uint createTime;
		uint expirationTime;
		rewardState state;
	}

	uint numRewards;

	// Hash of all reward contracts
	mapping (uint => Reward) rewards;



	function Market() public  // constructor
	{
	}

	function getRepoUrl() 
		public
		constant
		returns (string) 
	{
		return repo_url;
	}

	function setRepoUrl(string _repo_url)
		onlyOwner
	{
		repo_url = _repo_url;
	}

	function postReward(uint _issueNumber, uint _expirationTime)
		public
		payable
	{
		numRewards = numRewards + 1;
		rewards[numRewards].publisher = msg.sender;
		rewards[numRewards].rewardAmount = msg.value;
		rewards[numRewards].issueNumber = _issueNumber;
		rewards[numRewards].createTime = now;
		rewards[numRewards].expirationTime = _expirationTime;
		// throw an event that tells the client which record
	}

	function getReward(uint rewardId)
		public
		constant
		returns (
			uint issueNumber,
			uint rewardAmount,
			uint createTime,
			uint expirationTime
		)
	{
		return (
			rewards[rewardId].issueNumber,
			rewards[rewardId].rewardAmount,
			rewards[rewardId].createTime,
			rewards[rewardId].expirationTime
		);
	}

	function getNumRewards() public constant returns (uint)
	{
		return numRewards;
	}

	function getBalance() public constant returns (uint)
	{
		return this.balance;
	}

	function counterReward(uint rewardId) public payable
	{
		if (rewards[rewardId].publisher == 0) {
			throw; // not a valid reward
		}
		if (rewards[rewardId].counterParty != 0) {
			throw; // reward already has a counter party
		}
		if (rewards[rewardId].rewardAmount != msg.value) {
			throw; // transaction amount does not match reward amount
		}
		rewards[rewardId].counterParty = msg.sender;
	}

	function finalizeReward(uint rewardId, rewardState _rewardState) public
	{
		rewards[rewardId].state = _rewardState;

		// Won_publisher
		if (rewards[rewardId].state == rewardState.won_publisher)
		{
		    payoutNetZero(rewardId, rewards[rewardId].publisher);
		}

	    // Won_counterparty
		if (rewards[rewardId].state == rewardState.won_publisher)
		{
			payoutNetZero(rewardId, rewards[rewardId].counterParty);
		}

		// Expired
		// Incomplete, posted, countered
	}

	function payoutNetZero(uint rewardId, address payee)
	{
		// transfer from this contract to payee
		payee.transfer(rewards[rewardId].rewardAmount);
	}


}
