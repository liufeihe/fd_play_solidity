// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Create2AndNew} from "../src/Create2AndNew.sol";

contract Create2AndNewTest is Test {
    Create2AndNew public create2AndNew;

    function setUp() public {
        create2AndNew = new Create2AndNew();
    }

    // function test_deployTestContractWithCreate() public {
    //     (address addr1, address addr2) = create2AndNew.deployValueWithNewAndCreate();
    //     assertEq(addr1, addr2, "address is not equal");
    // }

    function test_deployTestContractWithCreate2() public {
        (address addrFromNew, address addrFromCalc) = create2AndNew.deployValueWithNewAndCreate2();
        assertEq(addrFromNew, addrFromCalc, "address is not equal");
        // assertEq(addrFromNew, address(0xB560478f5233567DC1B8b5E5C08138B91589B5d0), "address is not equal");
    }
}