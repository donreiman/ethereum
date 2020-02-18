pragma solidity ^0.6.1;
import './Mortal.sol';

contract Faucet is Mortal {
    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

    function withdraw(uint withdraw_amount) public {
        // limit withdrawal amount to 0.1 ETH
        require(withdraw_amount <= 0.1 ether, 'requested amount is too large');

        // confirm contract contains enough ether to cover withdrawal
        require(address(this).balance <= withdraw_amount, 'insufficient funds');

        // send requested amount of ether
        msg.sender.transfer(withdraw_amount);

        // emit event
        emit Withdrawal(msg.sender, withdraw_amount);
    }

    // accept ether sent to this contract
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}
