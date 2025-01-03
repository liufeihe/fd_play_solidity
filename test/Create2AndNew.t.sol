// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Create2AndNew} from "../src/Create2AndNew.sol";

contract Create2AndNewTest is Test {
    Create2AndNew public create2AndNew;

    function setUp() public {
        create2AndNew = new Create2AndNew();
    }

    function test_deployValueWithNew() public {
        uint256 args = 1;
        (address addrFromNew, address addrFromCalc) = create2AndNew.deployValueWithNew(args);
        console.log("addrFromNew", addrFromNew);
        console.log("addrFromCalc", addrFromCalc);
        assertEq(addrFromNew, addrFromCalc, "address is not equal");
    }

    function test_deployWithCreate2() public {
        uint256 args = 1;
        bytes memory bytecode = abi.encodePacked(
            vm.getCode("Create2AndNew.sol:ValueTest"), 
            abi.encode(args)
        );
        // bytes32 salt = keccak256(abi.encodePacked(abi.encode(args)));
        bytes32 salt = keccak256(abi.encodePacked(args));
        (address addr, address addrFromCalc) = create2AndNew.deployWithCreate2(bytecode, salt);
        console.log("addr", addr);
        console.log("addrFromCalc", addrFromCalc);
        assertEq(addr, addrFromCalc, "address is not equal");
    }
}