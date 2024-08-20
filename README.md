# ACADEMICTOKEN BY ERC20

This Solidity smart contract defines an ERC-20 token called "STUDY COIN" (symbol: STN) using the OpenZeppelin library. The contract is designed to manage student information and their associated tokens.

## Description

For this project, you will write a smart contract to create your own ERC20 token and deploy it using HardHat or Remix. Once deployed, you should be able to interact with it for your walk-through video. From your chosen tool, the contract owner should be able to mint tokens to a provided address and any user should be able to burn and transfer tokens.

## Getting Started

### Executing program

This code we are running on the online Solidity IDE that is https://remix.ethereum.org/ here we'll perform the code. as we are on the remix website just by clicking on the start coding we'll able to do coding in Solidity.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AcademicToken is ERC20 {

    struct Learner {
        uint id;
        address account;
        uint grade;
        uint tokenBalance;
    }

    uint private _learnerCount;
    mapping(address => uint) private _learnerIndex;
    address private _admin;

    modifier onlyAdmin() {
        require(msg.sender == _admin, "Caller is not the admin");
        _;
    }

    Learner[] private _learners;

    constructor() ERC20("ACADEMIC COIN", "ACD") {
        _admin = msg.sender;
        _mint(_admin, 10000000000 * 10 ** decimals()); // Mint with decimals consideration
    }

    function mintTokens(uint amount) external onlyAdmin {
        _mint(_admin, amount);
    }

    function registerLearner(address account, uint grade) external onlyAdmin {
        require(grade <= 100, "Grade must be between 0 and 100");
        require(_learnerIndex[account] == 0, "Learner already registered");

        Learner memory newLearner = Learner({
            id: _learnerCount,
            account: account,
            grade: grade,
            tokenBalance: balanceOf(account)
        });

        _learners.push(newLearner);
        _learnerIndex[account] = _learnerCount;
        _learnerCount++;
    }

    function getLearners() external view returns (Learner[] memory) {
        return _learners;
    }

    function transferTokens(address to, uint amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _transfer(msg.sender, to, amount);
    }

    function burnTokens(uint amount) external {
        _burn(msg.sender, amount);
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the ("Compile "the name of the file" ") for ex. comple first.sol button. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "newmy.sol" contract from the dropdown menu, and then click on the "Deploy" button. then u can see a the below of the option ' Deployed/Unpinned Contracts ' expand it and balances mint burn etc and now u can see our code is ready to run .

# Program Explanation

```
struct Learner {
        uint id;
        address account;
        uint grade;
        uint tokenBalance;
    }
```
Struct Definition: Defines a Learner struct to store details about each learner:
```
    uint private _learnerCount;
```
State Variable: _learnerCount keeps track of the number of learners registered in the contract. It is private to prevent external access.
```
    mapping(address => uint) private _learnerIndex;
```
Mapping: Maps an address to an index in the _learners array. This helps quickly locate a learner's data.
```
    constructor() ERC20("ACADEMIC COIN", "ACD") {
        _admin = msg.sender;
        _mint(_admin, 10000000000 * 10 ** decimals()); // Mint with decimals consideration
    }
```
Constructor: Initializes the contract:
Calls the parent ERC20 constructor to set the token name as "ACADEMIC COIN" and the symbol as "ACD".
Sets _admin to the address that deploys the contract (msg.sender).
```
    function mintTokens(uint amount) external onlyAdmin {
        _mint(_admin, amount);
    }
```
Function mintTokens: Allows the admin to mint new tokens:
The onlyAdmin modifier ensures that only the admin can call this function.
Calls _mint (inherited from ERC20) to create new tokens and assign them to the admin.
```
    function registerLearner(address account, uint grade) external onlyAdmin {
        require(grade <= 100, "Grade must be between 0 and 100");
        require(_learnerIndex[account] == 0, "Learner already registered");

        Learner memory newLearner = Learner({
            id: _learnerCount,
            account: account,
            grade: grade,
            tokenBalance: balanceOf(account)
        });

        _learners.push(newLearner);
        _learnerIndex[account] = _learnerCount;
        _learnerCount++;
    }
```
Function registerLearner: Registers a new learner:
Ensures the grade is between 0 and 100.
Checks that the learner is not already registered.
Creates a new Learner struct with the learner’s details.
Adds the new learner to the _learners array.

```
    function getLearners() external view returns (Learner[] memory) {
        return _learners;
    }
```
Function getLearners: Returns the list of all learners:
Provides a view of the _learners array, allowing external users to see the registered learners.
```
    function transferTokens(address to, uint amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _transfer(msg.sender, to, amount);
    }
```
Function transferTokens: Allows users to transfer tokens to another address:
Checks that the sender has enough tokens to transfer.
Transfers the specified amount of tokens from the sender to the recipient.
```
    function burnTokens(uint amount) external {
        _burn(msg.sender, amount);
    }
```
Function burnTokens: Allows users to burn (destroy) tokens:
Calls the _burn function (inherited from ERC20) to remove tokens from the sender's balance and decrease the total supply.

## Authors

1. Contributed by name : Ujjwala
2. Email ID : ujjwala622@gmail.com


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
