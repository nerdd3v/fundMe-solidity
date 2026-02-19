// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import {AggregatorV3Interface} from "../lib/chainlink-brownie-contracts/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library Math{
    function priceConversion()public view returns(uint256){
        AggregatorV3Interface f = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,)=f.latestRoundData();
        //1eth = 3000usd
        return uint256(5e18/answer);
    }

    function priceConversion(uint256 amount)public view returns(uint256){
        //amount is in eth (wei) itself/
        (,int256 answer,,,)= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
        return uint256(amount/uint256(answer));
    }
}