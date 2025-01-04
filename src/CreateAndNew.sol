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
        addrFromCalc = calculateCreateAddress(address(this), 1);
    }

    function deployWithCreate(bytes memory byteCode) public returns (address addr, address addrFromCalc) {
        assembly {
            addr := create(0, add(byteCode, 0x20), mload(byteCode))
        }
        require(addr != address(0), "deployment failed");

        addrFromCalc = calculateCreateAddress(address(this), 1);
    }

    // 
    // function calculateCreateAddress(address deployer, uint256 nounce) public pure returns (address) {
    //     bytes32 hash = keccak256(abi.encodePacked(
    //         deployer, 
    //         nounce
    //     ));
    //     return address(uint160(uint(hash)));
    // }

    /*
        提前获取使用create部署合约，形成的地址
        CREATE uses RLP-encoded values of the deployer address and nonce to derive the resulting address.
    */
    function calculateCreateAddress(address deployer, uint256 nonce) public pure returns (address) {
        if (nonce == 0) {
            return address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xd6), bytes1(0x94), deployer, bytes1(0x80)
            )))));
        } else if (nonce <= 0x7f) {
            return address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xd6), bytes1(0x94), deployer, uint8(nonce)
            )))));
        } else if (nonce <= 0xffff) {
            return address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xd7), bytes1(0x94), deployer, uint16(nonce)
            )))));
        } else if (nonce <= 0xffffff) {
            return address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xd8), bytes1(0x94), deployer, uint24(nonce)
            )))));
        } else {
            return address(uint160(uint(keccak256(abi.encodePacked(
                bytes1(0xd9), bytes1(0x94), deployer, uint32(nonce)
            )))));
        }
    }
}