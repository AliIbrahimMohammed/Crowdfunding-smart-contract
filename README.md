# Crowdfunding-smart-contract
pragma solidity ^0.7.0 - This specifies the version of Solidity that the contract is written in.

import "https://github.com/binance-chain/smart-contract-standards/blob/master/smart_contract_standard_library/SafeMath.sol"; and import "https://github.com/binance-chain/smart-contract-standards/blob/master/smart_contract_standard_library/SafeERC20.sol"; - These lines import two libraries: SafeMath and SafeERC20. SafeMath provides safe math functions (e.g. addition, subtraction, multiplication) that handle overflow and underflow automatically. SafeERC20 provides safe versions of the ERC20 token functions (e.g. transfer, transferFrom) that prevent integer overflow and underflow.

contract Crowdfunding - This declares the contract as a crowdfunding contract.

using SafeMath for uint256; and using SafeERC20 for IERC20; - These lines specify that the SafeMath and SafeERC20 libraries should be used for the uint256 and IERC20 types, respectively.

IERC20 public token; - This declares the token variable as an IERC20 type and makes it publicly accessible.

uint256 public goal; - This declares the goal variable as a uint256 type (an unsigned integer that can hold values up to 2^256 - 1) and makes it publicly accessible.

uint256 public deadline; - This declares the deadline variable as a uint256 type and makes it publicly accessible.

uint256 public totalRaised; - This declares the totalRaised variable as a uint256 type and makes it publicly accessible.

uint256 public totalBackers; - This declares the totalBackers variable as a uint256 type and makes it publicly accessible.

mapping(address => bool) public backers; - This declares the backers variable as a mapping that maps addresses to booleans and makes it publicly accessible.

constructor(IERC20 _token, uint256 _goal, uint256 _deadline) public { - This is the constructor function, which is called when the contract is deployed. It takes three arguments: _token (an IERC20 type), _goal (a uint256 type), and _deadline (a uint256 type). The public keyword makes the function publicly accessible.

token = _token; - This sets the token variable to the value of the _token argument.

goal = _goal; - This sets the goal variable to the value of the _goal argument.

deadline = _deadline; - This sets the deadline variable to the value of the _deadline argument.

function contribute(uint256 _amount) public payable { - This function allows backers to contribute funds to the crowdfunding campaign. It takes one argument: _amount (a uint256 type). The public and payable keywords make the function publicly accessible and allow it to receive ether.

require(_amount > 0, "Must contribute a positive amount"); -
