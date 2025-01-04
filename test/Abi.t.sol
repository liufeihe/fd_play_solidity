// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract AbiTest is Test {
    function setUp() public {

    }

    function test_keccak256() pure public {
        bytes32 dataHash = keccak256(
            "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
        );
        // uint256 a = uint256(dataHash);

        // console.log("hash", a);
        assertEq(dataHash, 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9);
    }
}
