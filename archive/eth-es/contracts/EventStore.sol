pragma solidity ^0.4.4;

contract EventStore {

    address public creator;
	uint public blockCreatedOn;

	event GenericEvent(uint256 id1, string string1);
	

	function EventStore() {
        creator = msg.sender;
        blockCreatedOn = block.number;
	}

	function log(uint256 id1, string string1) returns(bool) {
        GenericEvent(id1,string1);
		return true;
	}

}
