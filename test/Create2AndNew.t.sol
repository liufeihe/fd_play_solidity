// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Create2AndNew} from "../src/Create2AndNew.sol";

contract Create2AndNewTest is Test {
    Create2AndNew public create2AndNew;

    function setUp() public {
        create2AndNew = new Create2AndNew();
    }

    function test_deployTestContractWithCreate() public {
        (address addr1, address addr2) = create2AndNew.deployValueWithNewAndCreate();
        assertEq(addr1, addr2, "address is not equal");
    }
}