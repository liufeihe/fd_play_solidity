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
        (address addr1, address addr2) = create2AndNew.deployValueWithNewAndCreate2();
        assertEq(addr1, addr2, "address is not equal");
        assertEq(addr1, address(0xE61DD39dCC9b1C597aeC6d0dBAC910581503221f), "address is not equal");
    }
}