// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {Helper} from "./Helper.s.sol";

contract FundMeScript is Script {
    FundMe public _contract;
    Helper public heplerContract;
    address public priceFeed;

    function setUp() public {
        heplerContract = new Helper(block.chainid);
        priceFeed = heplerContract.getFeedAddress();
    }

    function run() public {
        vm.startBroadcast();

        _contract = new FundMe();

        vm.stopBroadcast();
    }
}
