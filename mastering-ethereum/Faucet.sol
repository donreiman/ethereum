pragma solidity ^0.6.1;

contract Faucet {
    function withdraw(uint withdraw_amount) public {
        // limit widthdrawl amount to 0.1 ETH = 100,000,000,000,000,000 wei
        require(withdraw_amount < 100000000000000000, 'insufficient funds');

        // send requested amount of ether
        msg.sender.transfer(withdraw_amount);
    }

    // accept ether sent to this contract
    receive() external payable {}
}

// ropsten network contract address: 0xeb0346aCbE1F99e5F9553A501062e07c6397976F