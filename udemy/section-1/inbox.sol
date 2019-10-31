pragma solidity  ^0.5.11;

contract Inbox {
    string public message;

    constructor(string memory initialMessage) public {
        message = initialMessage;
    }

    function SetMessage(string memory newMessage) public {
        message = newMessage;
    }

    function GetMessage() public view returns (string memory) {
        return message;
    }
}