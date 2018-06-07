pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/PausableToken.sol";

/**
 * @title BountieToken
 * @dev ERC20 Token that can be minted and paused.
 * It is meant to be used in a crowdsale contract.
 */

 contract BountieToken is MintableToken, PausableToken {

  string public constant name = "Bontie Coin";
  string public constant symbol = "BTIE";
  uint8 public constant decimals = 18;

}