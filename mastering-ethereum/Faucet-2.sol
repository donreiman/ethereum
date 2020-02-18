pragma solidity ^0.6.1;

contract Faucet {
    address payable owner;

    constructor() public {
        owner = msg.sender;
    }

    function destroy() public onlyOwner {
        selfdestruct(owner);
    }

    modifier onlyOwner {
        require (msg.sender == owner, 'unauthorized'); 
        _;
    } 

    function withdraw(uint withdraw_amount) public {
        // limit withdrawal amount to 0.1 ETH = 100,000,000,000,000,000 wei
        require(withdraw_amount < 100000000000000000, 'requested amount is too large');

        // send requested amount of ether
        msg.sender.transfer(withdraw_amount);
    }

    // accept ether sent to this contract
    receive() external payable {}
}

// ropsten network contract address: 0xCE195A4F8f2719eA7D5e2edCE87635A70DC244e4