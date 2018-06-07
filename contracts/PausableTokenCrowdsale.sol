pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "openzeppelin-solidity/contracts/token/ERC20/PausableToken.sol";

/**
* @title PausableTokenCrowdsale
* @dev This contract sets functions to pause / unpause distribution of the token.
*/

contract PausableTokenCrowdsale is Crowdsale, Ownable {

    /**
    * @dev Stops distribution of the token
    */
    function pauseToken() onlyOwner public {
        PausableToken(token).pause();
    }

    /**
    * @dev Unpause distribution of the token
    */
    function unpauseToken() onlyOwner public {
        PausableToken(token).unpause();
    }

}