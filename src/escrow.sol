pragma solidity ^0.4.0;

/*
Simple escrow contract that mediates disputes using a trusted arbiter
*/
contract Escrow {
    
    enum State {AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE, REFUNDED}
    State public currentState;
    
    modifier buyerOnly() { require(msg.sender == buyer || msg.sender == arbiter); _; }
    modifier sellerOnly() { require(msg.sender == seller || msg.sender == arbiter); _; }
    modifier inState(State expectedState) { require(currentState == expectedState); _; }
    
    address public buyer;
    address public seller;
    address public arbiter;
    
    function Escrow(address _buyer, address _seller, address _arbiter){
        buyer = _buyer;
        seller = _seller;
        arbiter = _arbiter;
    }
    
    function confirmPayment() buyerOnly inState(State.AWAITING_PAYMENT) payable {
        currentState = State.AWAITING_DELIVERY;
    }
    
    function confirmDelivery() buyerOnly inState(State.AWAITING_DELIVERY) {
        seller.send(this.balance);
        currentState = State.COMPLETE;
    }
    
    function refundBuyer() sellerOnly inState(State.AWAITING_DELIVERY) {
        buyer.send(this.balance);
        currentState = State.REFUNDED;
    }
}