pragma solidity ^0.7.0;

import "https://github.com/binance-chain/smart-contract-standards/blob/master/smart_contract_standard_library/SafeMath.sol";
import "https://github.com/binance-chain/smart-contract-standards/blob/master/smart_contract_standard_library/SafeERC20.sol";

contract Crowdfunding {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IERC20 public token;
    uint256 public goal;
    uint256 public deadline;
    uint256 public totalRaised;
    uint256 public totalBackers;
    mapping(address => bool) public backers;

    constructor(IERC20 _token, uint256 _goal, uint256 _deadline) public {
        token = _token;
        goal = _goal;
        deadline = _deadline;
    }

    function contribute(uint256 _amount) public payable {
        require(_amount > 0, "Must contribute a positive amount");
        require(now <= deadline, "Deadline has passed");
        require(totalRaised.add(_amount) <= goal, "Goal has been reached");

        token.transferFrom(msg.sender, address(this), _amount);
        totalRaised = totalRaised.add(_amount);
        totalBackers = totalBackers.add(1);
        backers[msg.sender] = true;
    }

    function refund() public {
        require(now > deadline, "Deadline has not passed");
        require(totalRaised < goal, "Goal has been reached");

        msg.sender.transfer(totalRaised);
        totalRaised = 0;
        totalBackers = 0;
        backers[msg.sender] = false;
    }

    function distributeTokens() public {
        require(now > deadline, "Deadline has not passed");
        require(totalRaised >= goal, "Goal has not been reached");

        uint256 tokensPerBacker = token.balanceOf(address(this)).div(totalBackers);
        for (uint256 i = 0; i < totalBackers; i++) {
            address backer = address(keccak256(abi.encodePacked(i)));
            if (backers[backer]) {
                backer.transfer(tokensPerBacker);
            }
        }
    }
}
