// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {Helper} from "./Helper.s.sol";

contract FundMeScript is Script {
    FundMe public _contract;
    address public feed;

    feed = new Helper(block.chainid).getFeedAddress();

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        _contract = new FundMe();

        vm.stopBroadcast();
    }
}
