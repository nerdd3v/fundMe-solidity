// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Math} from "./Math.sol";

//better use remappings
contract FundMe {

    using Math for uint256;

    struct userInfo{
        string name;
        uint256 amount;
    }

    address private priceFeed;
    uint256 public constant MINIMUM_FUND_IN_USD = 5;
    address private immutable I_OWNER; 
    mapping(address => userInfo) public fundInfo;
    address[] funders_arr;
    
    constructor(address _priceFeed){
        I_OWNER = msg.sender;
        priceFeed = _priceFeed;
    }

    function fundMe(string memory _name)public payable{
        require(msg.value >= 0.1 ether, "at least 0.1 ether needs to be funded");
        userInfo memory u = userInfo({name: _name, amount: msg.value});
        fundInfo[address(msg.sender)] = u;
        funders_arr.push(msg.sender);
    }

    function getPriceFeed()public view returns(address){
        return priceFeed;
    }

    function getConversion()public view returns(uint256){
        uint256 _amount = 10e18;
        return _amount.priceConversion();
    }

    function withdrawal()public onlyOwner{
        require(address(this).balance > 0, "not sufficient balance");
        for(uint256 i = 0; i < funders_arr.length ; i++){
            address funder = funders_arr[i];
            fundInfo[funder].amount = 0;
        }

        (bool sent, ) = I_OWNER.call{value: address(this).balance}("");

        require(sent, "the transfer to the owner failed");

        funders_arr = new address[](0);

    }

    function getOwner()public view returns(address){
        return I_OWNER;
    }

    modifier onlyOwner(){
        require(msg.sender == I_OWNER, "you are not the owner of the contract");
        _;
    }
}

