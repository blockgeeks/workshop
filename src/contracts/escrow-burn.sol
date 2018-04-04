pragma solidity ^0.4.21;

/*
Simple escrow contract that mediates disputes using a burn contract
*/
contract Escrow {

    enum State {UNINITIATED, IN_PROGRESS, COMPLETE}
    State public currentState;

    modifier inState(State expectedState) { require(currentState == expectedState); _; }
    modifier buyerOnly() { require(msg.sender == buyer); _; }

    address public buyer;
    address public seller;

    bool public buyer_in;
    bool public seller_in;

    function Escrow(address _buyer, address _seller){
        buyer = _buyer;
        seller = _seller;
    }

    function initiateContract() inState(State.UNINITIATED) payable {
        if (msg.sender == buyer) {
            buyer_in = true;
        }

        if (msg.sender == seller) {
            seller_in = true;
        }

        if (buyer_in && seller_in) {
            currentState = State.IN_PROGRESS;
        }
    }

    function confirmDelivery() buyerOnly inState(State.AWAITING_DELIVERY) {
        seller.send(this.balance);
        currentState = State.COMPLETE;
    }
}
