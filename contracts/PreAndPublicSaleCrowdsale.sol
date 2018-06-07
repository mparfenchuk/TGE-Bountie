pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";

/**
* @title PreAndPublicSaleCrowdsale
* @dev This contract determines the pause between presale and public sale.
*/
contract PreAndPublicSaleCrowdsale is TimedCrowdsale, Ownable {

    uint256 public preSaleEndTime;
    uint256 public publicSaleStartTime;

    /**
    * @dev Constructor, sets presale end time and public sale start time
    * @param _preSaleEndTime Presale end time
    * @param _publicSaleStartTime Public sale start time
    */
    constructor(uint256 _preSaleEndTime, uint256 _publicSaleStartTime) public {
        require(_preSaleEndTime >= openingTime
                && _publicSaleStartTime >= _preSaleEndTime
                && closingTime >= _publicSaleStartTime);

        preSaleEndTime = _preSaleEndTime;
        publicSaleStartTime = _publicSaleStartTime;
    }

    /**
    * @dev Function determines the pause between presale and public sale
    */
    function isNoPauseBetweenPreAndPublicSale() public view returns (bool) {

        if (block.timestamp > preSaleEndTime
            && block.timestamp < publicSaleStartTime){
            return false;
        }

        return true;
    }

    /**
    * @dev Override for function that validate purchase
    * Checking for the pause between presale and public sale
    */
    function _preValidatePurchase(
        address _beneficiary,
        uint256 _weiAmount
    )
        internal
    {
        super._preValidatePurchase(_beneficiary, _weiAmount);
        require(isNoPauseBetweenPreAndPublicSale());
    }

}