// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract ProductLot {
    address public owner;
    string public productName;
    uint public quantity;
    uint public productionDate;
    uint public lotNumber;
    bool public approvedForSale;

    struct Prescription {
        uint expiryDate;
        uint quantity;
        string drugName;

    }

    mapping(address => mapping(uint => Prescription)) public prescriptions; // mapping of prescription details for each drug
    mapping(address => mapping(uint => mapping(uint => Prescription))) public patientPrescriptions; // mapping of prescription details for each patient

    mapping(uint => Patient) public patients; // mapping of patient details for each patient
    uint public numPatients; // mapping of prescription details for each patient


    struct Patient {
        string name;
        uint age;
        mapping(uint => Prescription) prescriptions; // mapping of prescription details for each drug
        mapping(string => string) medicalRecords; // nested mapping for medical records
        mapping(uint => Patient) patients; // mapping of patient details for each patient
        uint numPatients;
    }

    constructor(string memory _productName, uint _quantity, uint _productionDate, uint _lotNumber) {
        owner = msg.sender;
        productName = _productName;
        quantity = _quantity;
        productionDate = _productionDate;
        lotNumber = _lotNumber;
        approvedForSale = false;
    }

    function changeOwner(address newOwner) public {
        require(msg.sender == owner, "Only the current owner can change the owner.");
        owner = newOwner;
    }

    function getProductDetails() public view returns (string memory, uint, uint, uint, bool) {
        return (productName, quantity, productionDate, lotNumber, approvedForSale);
    }

    function approveSale() public {
        require(msg.sender == owner, "Only the owner can approve the sale.");
        uint totalPrescriptionQuantity = 0;
        for (uint i = 0; i < quantity; i++) {
            Prescription storage prescription = prescriptions[msg.sender][i];
            if (prescription.expiryDate == 0 || prescription.expiryDate >= block.timestamp) {
                totalPrescriptionQuantity += prescription.quantity;
            }
        }
        require(totalPrescriptionQuantity >= quantity, "Not enough valid prescriptions.");
        approvedForSale = true;
    }

    function setPrescriptionExpiryDate(uint drugIndex, uint _expiryDate, uint _quantity, string memory _drugName) public {
    require(_expiryDate > block.timestamp, "Expiry date must be in the future.");
    prescriptions[msg.sender][drugIndex] = Prescription(_expiryDate, _quantity, _drugName);
}

function checkPrescription(address patient, uint drugIndex, uint _expiryDate, uint _quantity, string memory _drugName) public returns (uint) {
    uint patientId = uint(keccak256(abi.encodePacked(patient, drugIndex, _expiryDate, _quantity, _drugName)));
    require(patientPrescriptions[msg.sender][drugIndex][patientId].expiryDate == 0 || patientPrescriptions[msg.sender][drugIndex][patientId].expiryDate >= block.timestamp, "Prescription has expired.");
    patientPrescriptions[msg.sender][drugIndex][patientId] = Prescription(_expiryDate, _quantity, _drugName);
    return patientId;
}





    function getPatientDetails(uint patientId) public view returns (string memory, uint, uint) {
        require(patientId < numPatients, "Invalid patient ID.");
        Patient storage patient = patients[patientId];
        return (patient.name, patient.age, patient.prescriptions[lotNumber].expiryDate);
    }

    function addPatient(string memory name, uint age) public {
    Patient storage newPatient = patients[numPatients];
    newPatient.name = name;
    newPatient.age = age;
    newPatient.numPatients = 0;
    
    numPatients++;
    
    // Initialize empty mappings for prescriptions and medical records
    for (uint i = 0; i < quantity; i++) {
    newPatient.prescriptions[i] = Prescription(0, 0, "");
}
for (uint i = 0; i < quantity; i++) {
    newPatient.medicalRecords[productName] = "";
}

}



}
