pragma solidity ^0.4.18;

contract Fifa {
  string name;
  uint age;

  function setPlayer(string _name, uint _age) public {
    name = _name;
    age = _age;
  }

  function getPlayer() public constant returns (string, uint) {
    return (name, age);
  }
}
