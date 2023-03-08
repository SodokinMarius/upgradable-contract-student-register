// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./upgradable_proxy.sol";
import "./student_register_two_persons.sol";
import "./studentObject.sol";

contract ProxyContractTest {

// the address of current deploying address of StudentRegisterProxy ==>  0x8046085fb6806cAa9b19a4Cd7b3cd96374dD9573
 
address public  addressOfLogicContract = address(0x8046085fb6806cAa9b19a4Cd7b3cd96374dD9573);
StudentRegisterProxy public proxy = new StudentRegisterProxy(addressOfLogicContract);

// Obtenir l'adresse actuelle de l'implémentation du contrat de logique
address implementation = proxy.currentImplementation();


    // Fonction pour appeler la fonction registerStudent du contrat de logique via le contrat proxy
    function registerStudent(
        address _studentAddress,
        string memory _name,
        string memory _surname,
        string memory _birthday, 
        uint8 _gender,
        string memory _residence,
        string memory _email,
        string memory _phone
    ) public {

        // Encodage de la fonction registerStudent avec les arguments
        bytes memory data = abi.encodeWithSignature(
            "registerStudent(address,string,string,string,uint8,string,string,string)",
            _studentAddress,
            _name,
            _surname,
            _birthday,
                _gender,
            _residence,
            _email,
            _phone
        );

        // Execution de la fonction registerStude8nt du contrat de logique via le contrat proxy
        (bool success, ) = implementation.delegatecall(data);
        require(success, "Execution of function failed.");
    }
}