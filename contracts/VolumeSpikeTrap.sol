// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ITrap {
    function collect() external view returns (bytes memory);
    function shouldRespond(bytes[] calldata data) external pure returns (bool, bytes memory);
}

contract VolumeSpikeTrap is ITrap {
    address public constant target = 0x35aA15ad2FbD9FFf7FdC7f0868caEc95a5c198E3;
    uint256 public constant thresholdDecrease = 0.1 ether;

    function collect() external view override returns (bytes memory) {
        return abi.encode(target.balance);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length < 2) return (false, "Insufficient data");

        uint256 currentBalance \= abi\.decode\(data\[0\], \(uint256\)\);
        uint256 previousBalance \= abi\.decode\(data\[1\], \(uint256\)\);

        if \(previousBalance \> currentBalance && \(previousBalance \- currentBalance\) \>\= thresholdDecrease\) \{
            return \(true, ""\);
        }

        return (false, "");
    }
}
