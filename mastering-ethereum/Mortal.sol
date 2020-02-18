pragma solidity ^0.6.1;
import './Owned.sol';

contract Mortal is Owned {
    function destroy() public onlyOwner {
        selfdestruct(owner);
    }
}