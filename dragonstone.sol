pragma solidity ^0.4.0;

/*
Currency that can only be issued by its creator and transferred to anyone
*/
contract DragonStone {
    address public creator;
    mapping (address => uint) public balances;

    // event that notifies when a transfer has completed
    event Delivered(address from, address to, uint amount);

    function DragonStone() {
        creator = msg.sender;
    }

    function create(address receiver, uint amount) {
        if (msg.sender != creator) return;
        balances[receiver] += amount;
    }

    function transfer(address receiver, uint amount) {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        Delivered(msg.sender, receiver, amount);
    }
}