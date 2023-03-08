// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./studentObject.sol";

contract StudentRegister is StudentObject {
    
    address public principal;

// Set the address of the principal when deploying the contract
constructor(address _principal) {
    principal = _principal;
}

// Modifier to restrict access to only the principal
modifier onlyPrincipal() {
    require(msg.sender == principal, "Only the principal can perform this action.");
    _;
}

// Register a new student with the specified information
function registerStudent(
    address _studentAddress,
    string memory _name,
    string memory _surname,
    string memory _birthday, 
    Gender _gender, 
    string memory _residence,
    string memory _email,
    string memory _phone) public override onlyPrincipal
{
    // Call the registerStudent function from the base contract
    super.registerStudent(_studentAddress, _name, _surname, _birthday, _gender, _residence, _email, _phone);
}

 
}
