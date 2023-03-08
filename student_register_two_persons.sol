// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./studentObject.sol";

contract LimitedStudentRegister is StudentObject{
    address public authorizedPerson1;
address public authorizedPerson2;

constructor(address _authorizedPerson1, address _authorizedPerson2) {
    authorizedPerson1 = _authorizedPerson1;
    authorizedPerson2 = _authorizedPerson2;
}

// Modifier that allows only authorized persons to execute the function
modifier onlyAuthorized() {
    require(msg.sender == authorizedPerson1 || msg.sender == authorizedPerson2, "Only authorized persons can perform this action.");
    _;
}

// Function to register a new student that can only be executed by authorized persons
function registerStudent(
    address _studentAddress,
    string memory _name,
    string memory _surname,
    string memory _birthday, 
    Gender _gender, 
    string memory _residence,
    string memory _email,
    string memory _phone
) public override onlyAuthorized {
    super.registerStudent(_studentAddress,_name,_surname,_birthday,_gender,_residence,_email,_phone);
}
}
