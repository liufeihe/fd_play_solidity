// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Vm} from "forge-std/Test.sol";
import {ValueTest} from "../../src/Create2AndNew.sol";

library Deployer {
    Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    function deployValueTest(uint256 val) internal returns (ValueTest erc20) {
        bytes memory args = abi.encode(val);
        bytes memory bytecode = abi.encodePacked(
            vm.getCode("Create2AndNew.sol:ValueTest"), 
            args
        );
        bytes32 salt = keccak256(abi.encodePacked(args));
        assembly {
            erc20 := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
    }
}
