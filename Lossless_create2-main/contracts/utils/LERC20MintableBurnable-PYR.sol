// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LERC20.sol";

contract LERC20MintableBurnable is Context, LERC20 {

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

    modifier lssBurn(address account, uint256 amount) {
        if (isLosslessOn) {
            lossless.beforeBurn(account, amount);
        } 
        _;
    }


    modifier lssMint(address account, uint256 amount) {
        if (isLosslessOn) {
            lossless.beforeMint(account, amount);
        } 
        _;
    }


    function burn(uint256 amount) public virtual lssBurn(_msgSender(), amount) {
        _burn(_msgSender(), amount);
    }

    function burnFrom(address account, uint256 amount) public virtual lssBurn(account, amount) {
        uint256 currentAllowance = allowance(account, _msgSender());
        require(currentAllowance >= amount, "ERC20: burn amount exceeds allowance");
        unchecked {
            _approve(account, _msgSender(), currentAllowance - amount);
        }
        _burn(account, amount);
    }

    function mint(address to, uint256 amount) public virtual lssMint(to, amount) {
        require(_msgSender() == admin, "LERC20: Must be admin");
        _mint(to, amount);
    }
}