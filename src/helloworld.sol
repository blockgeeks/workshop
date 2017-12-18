pragma solidity ^0.4.18;

contract HelloWorld {
    
    address owner;
    string text;
    
    function HelloWorld(string greeting){
        owner = msg.sender;    
        text = greeting;
    }
    
    function sayHello() returns (string) {
        return text;
    }
    
    function setGreeting(string greeting){
        text = greeting;
    }
}