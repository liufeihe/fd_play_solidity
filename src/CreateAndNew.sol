// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ValueTest {
    uint256 public value;

    constructor(uint256 _value) {
        value = _value;
    }
}

contract CreateAndNew {

    function deployValueWithNew(uint256 val) public returns (address addrFromNew, address addrFromCalc) {
        ValueTest v = new ValueTest(val);
        addrFromNew = address(v);
        addrFromCalc = calculateCreateAddress(address(this), 0);
    }

    function deployWithCreate(bytes memory byteCode) public returns (address addr, address addrFromCalc) {
        assembly {
            addr := create(0, add(byteCode, 0x20), mload(byteCode))
        }
        require(addr != address(0), "deployment failed");

        addrFromCalc = calculateCreateAddress(address(this), 0);
    }

    // 提前获取使用create部署合约，形成的地址
    function calculateCreateAddress(address deployer, uint256 nounce) public pure returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(
            deployer, 
            nounce
        ));
        return address(uint160(uint(hash)));
    }
}