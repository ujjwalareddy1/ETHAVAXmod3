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
