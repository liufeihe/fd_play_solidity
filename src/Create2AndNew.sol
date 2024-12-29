// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ValueTest {
    uint256 public value;

    constructor(uint256 _value) {
        value = _value;
    }
}

contract Create2AndNew {

    function deployValueWithNewAndCreate() public returns (address addr1, address addr2) {
        ValueTest v = new ValueTest(1);
        addr1 = address(v);

        addr2 = calculateCreateAddress(address(this), 0);
    }

    function deployWithCreate(bytes memory byteCode) public returns (address addr) {
        assembly {
            addr := create(0, add(byteCode, 0x20), mload(byteCode))
        }
        require(addr != address(0), "deployment failed");
    }

    // 提前获取使用create2部署合约，形成的地址
    function calculateCreateAddress(address deployer, uint256 nounce) public pure returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(
            deployer, 
            nounce
        ));
        return address(uint160(uint(hash)));
    }

    function deployValueWithNewAndCreate2() public returns (address addr1, address addr2) {
        uint256 arg = 1;
        bytes32 salt = keccak256(abi.encodePacked(arg));
        
        ValueTest v = new ValueTest{salt: salt}(arg);
        addr1 = address(v);

        bytes memory byteCode = abi.encodePacked(
            type(ValueTest).creationCode,
            abi.encode(arg)
        );

        addr2 = calculateCreate2Address(address(this), byteCode, salt);
    }

    // 使用create2部署
    function deployWithCreate2(bytes memory byteCode, uint256 salt) public returns (address addr) {
        assembly {
            addr := create2(0, add(byteCode, 0x20), mload(byteCode), salt)
        }
        require(addr != address(0), "deployment failed");
    }

    // 提前获取使用create2部署合约，形成的地址
    function calculateCreate2Address(address deployer, bytes memory byteCode, bytes32 salt) public pure returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(
            bytes1(0xff),
            deployer,
            salt,
            keccak256(byteCode)
        ));
        return address(uint160(uint(hash)));
    }
}