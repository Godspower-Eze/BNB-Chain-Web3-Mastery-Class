// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

contract BuyMeACoffee {

    address payable public owner;

    struct Memo {
        uint256 amount;
        uint256 time;
        string name;
        string message;
    }

    event NewMemo (
        uint256 amount,
        uint256 time,
        string name,
        string message
    );

    Memo[] public memos;

    constructor() {
        owner = payable(msg.sender);
    }

    function gift(string memory name, string memory message) external payable {
        require(msg.value > 0, "Sorry. Please send money");
        Memo memory memo = Memo(msg.value, block.timestamp, name, message);
        memos.push(memo);
        emit NewMemo(msg.value, block.timestamp, name, message);
    }

    function withdraw() external {
        require(owner == msg.sender, "You are not the owner");
        uint256 balance = address(this).balance;
        owner.transfer(balance);
    }
}
