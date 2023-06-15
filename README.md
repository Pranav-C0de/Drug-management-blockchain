# drug-management
Drug Prescription Management through Blockchain
This is a decentralized drug prescription management system built on blockchain. The system allows doctors to create and sign prescriptions, and pharmacies to verify and fill prescriptions. The entire process is transparent and tamper-proof, ensuring that patients receive the correct medication and dosage.

Features
Decentralized prescription management
Secure and transparent record-keeping
Doctor authentication and prescription signing
Pharmacy verification and prescription filling
Prescription tracking and history
Technologies Used
Ethereum blockchain
Solidity smart contracts
Truffle framework
Web3.js library
React.js front-end
Installation
Clone the repository:
bash
Copy code
git clone https://github.com/username/drug-prescription-management.git
Install dependencies:
bash
Copy code
cd drug-prescription-management
npm install
Configure the project:
Create a .env file in the root directory and add the following environment variables:

makefile
Copy code
REACT_APP_INFURA_ID=<your Infura Project ID>
REACT_APP_CONTRACT_ADDRESS=<the address of the deployed smart contract>
Run the project:
sql
Copy code
npm start
Usage
Connect to the Ethereum network:
In order to interact with the smart contract, you need to connect to the Ethereum network. You can use MetaMask or any other Ethereum wallet to do this.

Create a prescription:
As a doctor, you can create a new prescription by entering the patient's information and the medication details. The prescription will be stored on the blockchain and can be verified by pharmacies.

Verify a prescription:
As a pharmacy, you can verify a prescription by entering the prescription ID and checking that it matches the prescription details on the blockchain. Once verified, you can fill the prescription and mark it as completed.

View prescription history:
Patients can view their prescription history and track the status of their prescriptions using the front-end interface.

Contributing
Contributions are welcome! Please fork the repository and create a pull request with your changes.

License
This project is licensed under the MIT License.
