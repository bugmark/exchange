pragma solidity ^0.4.4;

contract EventStore {

    address public creator;
	uint public blockCreatedOn;

	event GenericEvent(uint256 id1, uint256 id2, uint256 id3);
	

	function EventStore() {
        creator = msg.sender;
        blockCreatedOn = block.number;
	}

	function log(uint256 id1, uint256 id2, uint256 id3) returns(bool) {
        GenericEvent(id1,id2,id3);
		return true;
	}

}
