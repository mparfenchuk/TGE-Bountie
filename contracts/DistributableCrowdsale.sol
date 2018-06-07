pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "./PausableTokenCrowdsale.sol";

/**
* @title DistributableCrowdsale
* @dev This contract distributes tokens to the particular addresses when finishes.
*/
contract DistributableCrowdsale is FinalizableCrowdsale, MintedCrowdsale, PausableTokenCrowdsale {

    using SafeMath for uint256;

    address public teamWallet;
    address public novumWallet;

    /**
    * @dev Constructor, set addresses
    * @param _teamWallet Address of the management team
    * @param _novumWallet Address of the novum capital
    */
    constructor(address _teamWallet, address _novumWallet) public {
        teamWallet = _teamWallet;
        novumWallet = _novumWallet;
    }

    /**
    * @dev Override for function that finish a crowdsale
    * Distribute tokens to the addresses and finish minting
    */
    function finalization() internal {
        
        // Get all tokens
        uint256 totalSupply = MintableToken(token).totalSupply();
        // 20% to the team
        uint256 teamTokens = totalSupply.mul(20).div(100);
        // 5% to the novum capital
        uint256 novumTokens = totalSupply.mul(5).div(100);

        require(MintableToken(token).mint(teamWallet, teamTokens)
                && MintableToken(token).mint(novumWallet, novumTokens)
                && MintableToken(token).finishMinting());

        // Also it unpauses distribution of the token
        unpauseToken();
    }
}