pragma solidity ^0.4.0;

/* 
Simple contract that returns a greeting
*/
contract Hodor {
    address creator;
    string greeting;

    function Hodor(string _greeting) {
        greeting = _greeting;
        creator = msg.sender;
    }

    // returns the current greeting
    function greet() constant returns (string) {
        return greeting;
    }
    
    // changes the current greeting
    function setGreeting(string _greeting) {
        greeting = _greeting;
    }
}