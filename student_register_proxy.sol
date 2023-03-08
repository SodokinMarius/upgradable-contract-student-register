// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StudentRegisterProxy {
    // Storage variables to keep track of the current implementation and owner
    address public currentImplementation;
    address public owner;

    // Constructor to set the initial implementation and owner
    constructor(address _initialImplementation) {
        currentImplementation = _initialImplementation;
        owner = msg.sender;
    }

    // Function to upgrade the implementation of the contract
    function upgrade(address _newImplementation) public {
        // Only the owner can upgrade the contract
        require(msg.sender == owner, "Only the owner can upgrade the contract.");
        currentImplementation = _newImplementation;
    }

    // Fallback function that forwards all calls to the current implementation
    fallback() external payable {
        address implementation = currentImplementation;

        assembly {
            // Copy the calldata to memory
            calldatacopy(0, 0, calldatasize())
            // Delegate the call to the implementation contract, passing in the calldata
            let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
            // Copy the return data to memory
            returndatacopy(0, 0, returndatasize())
            // Check if the delegatecall was successful
            switch result
            // If delegatecall returned an error, revert with the return data
            case 0 { revert(0, returndatasize()) }
            // If delegatecall was successful, return the return data
            default { return(0, returndatasize()) }
        }
    }
}
