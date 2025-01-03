// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {CreateAndNew} from "../src/CreateAndNew.sol";

contract CreateAndNewTest is Test {
    CreateAndNew public createAndNew;

    function setUp() public {
        createAndNew = new CreateAndNew();
    }

    function test_deployValueWithNew() public {
        uint256 args = 1;
        (address addrFromNew, address addrFromCalc) = createAndNew.deployValueWithNew(args);
        console.log("addrFromNew", addrFromNew);
        console.log("addrFromCalc", addrFromCalc);
        // assertEq(addrFromNew, addrFromCalc, "address is not equal");
    }

    function test_deployWithCreate() public {
        uint256 args = 1;
        bytes memory bytecode = abi.encodePacked(
            vm.getCode("Create2AndNew.sol:ValueTest"), 
            abi.encode(args)
        );
        (address addr, address addrFromCalc) = createAndNew.deployWithCreate(bytecode);
        console.log("addr", addr);
        console.log("addrFromCalc", addrFromCalc);
        // assertEq(addr, addrFromCalc, "address is not equal");
    }
}