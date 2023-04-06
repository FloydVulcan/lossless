// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LERC20.sol";

contract LERC20_WLAVA is Context, LERC20 {
    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);
    constructor(
    uint256 totalSupply_, 
    string memory name_, 
    string memory symbol_, 
    address admin_, 
    address recoveryAdmin_, 
    uint256 timelockPeriod_, 
    address lossless_
    ) LERC20(
    totalSupply_, 
    name_, 
    symbol_, 
    admin_, 
    recoveryAdmin_, 
    timelockPeriod_, 
    lossless_
    ) {}

    // modifier lssBurn(address account, uint256 amount) {
    //     if (isLosslessOn) {
    //         lossless.beforeBurn(account, amount);
    //     } 
    //     _;
    // }


    // modifier lssMint(address account, uint256 amount) {
    //     if (isLosslessOn) {
    //         lossless.beforeMint(account, amount);
    //     } 
    //     _;
    // }

   fallback() external payable{
        deposit();
    }
    receive() external payable{}

    // function deposit() public payable virtual lssMint(msg.sender, msg.value){
    //    require(_msgSender() == admin, "LERC20: Must be admin");
    //     _mint(msg.sender, msg.value);
    //     emit Deposit(msg.sender, msg.value);
    // }
    
  function deposit() public payable{
      _mint(msg.sender, msg.value);
      emit Deposit(msg.sender, msg.value);
    }


    // function withdraw(uint _amount) external virtual lssBurn(_msgSender(), _amount) {
    //     _burn(msg.sender, _amount);
    //     payable(msg.sender).transfer(_amount);
    //     emit Withdraw(msg.sender, _amount);
    // }


  function withdraw(uint _amount) external  {
        _burn(msg.sender, _amount);
        payable(msg.sender).transfer(_amount);
        emit Withdraw(msg.sender, _amount);
    }

}