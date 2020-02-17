pragma solidity ^0.6.1;

contract Inbox {
    string public message;

    constructor(string memory initialMessage) public {
        message = initialMessage;
    }

    function SetMessage(string memory newMessage) public {
        message = newMessage;
    }
}

// Ropsten Testnet Network
// Contract 0x68618aeE6bF43944EE6F709d9Ee2C24706b77F49