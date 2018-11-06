pragma solidity ^0.4.25;

contract DragonStone {

    address public creator;
    mapping (address => uint) public balances;

    event Transfered(address from, address to, uint amount);

    constructor() public {
        creator = msg.sender;
    }

    function create(address receiver, uint amount) public {
        require(msg.sender == creator);
        balances[receiver] += amount;
    }

    function transfer(address receiver, uint amount) public {
        require(balances[msg.sender] > amount);
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfered(msg.sender, receiver, amount);
    }
}
