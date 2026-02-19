// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {FundMeScript} from "../script/FundMe.s.sol";
import {FundMe} from "../src/FundMe.sol";

contract CounterTest is Test {
    FundMeScript public script;
    FundMe public deployedContract;

    function setUp() public {
        script = new FundMeScript();
        // deployedContract = script.run();
    }

    function testOwner()public{
        vm.prank(0x20d99Eb01562f040e1c2716bd7cB48C5b450b2D0);
        deployedContract = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        assertEq(deployedContract.getOwner(), 0x20d99Eb01562f040e1c2716bd7cB48C5b450b2D0, "the owner does not match");
    }

    function testOwnerOnlyWithdrawal()public payable{
        address alice = makeAddr("alice");
        vm.deal(alice, 10 ether);
        vm.prank(0x20d99Eb01562f040e1c2716bd7cB48C5b450b2D0);
        deployedContract = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        //fund
        vm.prank(alice);
        deployedContract.fundMe{value: 2 ether}("alice");
        vm.prank(0x20d99Eb01562f040e1c2716bd7cB48C5b450b2D0);
        deployedContract.withdrawal();
    }

    function testFund()public payable{
        address alice = makeAddr("alice");
        vm.deal(alice, 1 ether);
        deployedContract = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        vm.prank(alice);
        deployedContract.fundMe{value: 1 ether}("alice");
        assertEq(address(deployedContract).balance, 1 ether, "bo");
    }

}
