pragma solidity ^0.6.1;

contract Owned {
    address payable owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require (msg.sender == owner, 'unauthorized');
        _;
    }
}