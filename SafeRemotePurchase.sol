//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.17;
contract Safe{
    uint public price;
    address payable public seller;
    address payable public buyer;

    enum State{
        Created,
        Locked,
        Release,
        Inactive
    }
    State public state;

    constructor()payable{ 
        require(msg.value != 0, "Please pay the 2X amount of the smart contract to deploy the contract");
        seller = payable(msg.sender);
        price = msg.value / 2;
    }

    ///The function cannot be called at the current state.
    error InvalidState();

    ///Only the buyer can call this message
    error InvalidBuyer();

     ///Only the seller can call this message
    error InvalidSeller();

    modifier inState(State _state){
        if (state != _state){
            revert InvalidState();
        }
        _;
    }

    modifier onlyBuyer(){
        if (msg.sender != buyer){
            revert InvalidBuyer();
        }
        _;
    }

    modifier onlySeller(){
        if (msg.sender != seller){
            revert InvalidSeller();
        }
        _;
    }

    function  confirmPurchase()external inState(State.Created) payable{
        require(msg.value == 2*price, "Please send in  2X the purchase amount");
        buyer = payable(msg.sender);
        state = State.Locked;
    }

    function confirmReceive() external onlyBuyer inState(State.Locked){
        state = State.Release;
        buyer.transfer(price);
    }
    
    function paySeller() external inState(State.Release) onlySeller {
        state = State.Inactive;
        seller.transfer(3 * price);
    }

    function abort() external onlySeller inState(State.Created){
        state = State.Inactive;
        seller.transfer(address(this).balance);
    }
}