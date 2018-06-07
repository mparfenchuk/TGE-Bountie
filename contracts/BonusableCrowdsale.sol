pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "./PreAndPublicSaleCrowdsale.sol";

/**
* @title BonusableCrowdsale
* @dev This is a contract that gives particular rate depending on the sale or pricing slabs status.
*/
contract BonusableCrowdsale is PreAndPublicSaleCrowdsale {

    using SafeMath for uint256;

    function getCurrentRate() public view returns (uint256) {
        
        // PreSale bonus
        if (block.timestamp < preSaleEndTime){
            return rate.add(rate.mul(15).div(100));
        }

        // First pricing slab with bonus 20% after presale
        if (weiRaised <= 9375 ether){
            return rate.add(rate.mul(20).div(100));
        }

        // Second pricing slab with bonus 15%
        if (weiRaised <= 13043 ether){
            return rate.add(rate.mul(15).div(100));
        }

        // Default rate
        return rate;
    }

    /**
    * @dev Override for crowdsale function that calculate amount of tokens
    * @param _weiAmount Value in wei
    */
    function _getTokenAmount(uint256 _weiAmount)
        internal view returns (uint256)
    {
        uint256 currentRate = getCurrentRate();
        return currentRate.mul(_weiAmount);
    }
}