pragma solidity ^0.4.21;

/*
Simple escrow contract that mediates disputes using a burn contract
*/
contract Escrow {

    enum State {UNINITIATED, AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE}
    State public currentState;

    modifier inState(State expectedState) { require(currentState == expectedState); _; }
    modifier buyerOnly() { require(msg.sender == buyer); _; }
    modifier correctPrice() { require(msg.value == price); _; }
    modifier correctDeposit() { require(msg.value == deposit); _; }

    address public buyer;
    address public seller;

    bool public buyer_in;
    bool public seller_in;

    uint public price;
    uint public deposit;

    function Escrow(address _buyer, address _seller, uint _price, uint _deposit){
        buyer = _buyer;
        seller = _seller;
        price = _price;
        deposit = _deposit;
    }

    function initiateContract() correctDeposit inState(State.UNINITIATED) payable {
        if (msg.sender == buyer) {
            buyer_in = true;
        }
        if (msg.sender == seller) {
            seller_in = true;
        }
        if (buyer_in && seller_in) {
            currentState = State.AWAITING_PAYMENT;
        }
    }

    function confirmPayment() buyerOnly correctPrice inState(State.AWAITING_PAYMENT) payable {
        currentState = State.AWAITING_DELIVERY;
    }

    function confirmDelivery() buyerOnly inState(State.AWAITING_DELIVERY) {
        seller.send(price);
        seller.send(deposit);
        buyer.send(deposit)
        currentState = State.COMPLETE;
    }
}
