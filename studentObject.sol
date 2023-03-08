// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**

@title StudentObject

@dev A contract for storing student information as a struct object.
*/
contract StudentObject {
// Define an enumeration for the student's gender
enum Gender {MALE, FEMALE, OTHER}


//Event declaring

event Register(address,Student,string);

// Define the student object structure
struct Student {
    string name;
    string surname;
    string birthday;
    Gender gender;
    string residence;
    string email;
    string phone;
}

// Map each student address to their corresponding student object
mapping(address => Student) public students;


/**

@dev Checks if a student is registered.
@param _studentAddress The address of the student to check.
@return A boolean indicating if the student is registered or not.
*/

function isRegistered(address _studentAddress) public virtual view returns (bool) {
return bytes(students[_studentAddress].name).length > 0;
}


/**
0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB

@dev Registers a new student.
@param _studentAddress The address of the student being registered.
@param _name The student's name.
@param _surname The student's surname.
@param _birthday The student's birthday.
@param _gender The student's gender.
@param _residence The student's residence.
@param _email The student's email.
@param _phone The student's phone number.
*/
function registerStudent(
    address _studentAddress,
    string memory _name,
    string memory _surname,
    string memory _birthday,
    Gender _gender,
    string memory _residence,
    string memory _email,
    string memory _phone
) public virtual {

    require(!isRegistered(_studentAddress),"This student is already registered !");

    Student memory newStudent = Student(_name, _surname, _birthday, _gender, _residence, _email, _phone);
    students[_studentAddress] = newStudent;

    //event emitting 
    emit Register(msg.sender,newStudent,"registerStudent(...)");
}



/**

@dev Gets a student's information.
@param _studentAddress The address of the student to get information for.
@return The student's information as a tuple of strings and their gender as an enumeration.
*/
function getStudentInfos(address _studentAddress) public virtual view returns (
    string memory,
    string memory,
    string memory,
    Gender,
    string memory,
    string memory,
    string memory
) {
require(isRegistered(_studentAddress),"This student is not registered !");
return (
    students[_studentAddress].name,
    students[_studentAddress].surname,
    students[_studentAddress].birthday,
    students[_studentAddress].gender,
    students[_studentAddress].residence,
    students[_studentAddress].email,
    students[_studentAddress].phone
);
}
}