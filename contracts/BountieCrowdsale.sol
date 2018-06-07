pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "./BonusableCrowdsale.sol";
import "./DistributableCrowdsale.sol";
import "./BountieToken.sol";

/**
 * @title BountieCrowdsale
 * @dev This is a crowdsale contract.
 * CappedCrowdsale sets a max boundary for raised funds.
 * BonusableCrowdsale returns a rate.
 * DistributableCrowdsale distributes tokens to the particular addresses when finishes.
 */
contract BountieCrowdsale is CappedCrowdsale, BonusableCrowdsale, DistributableCrowdsale {

    /**
   * @param _openingTime Time when crowdsale starts
   * @param _closingTime Time when crowdsale ends
   * @param _preSaleEndTime Time when presale ends
   * @param _publicSaleStartTime Time when public sale starts
   * @param _rate Number of token units a buyer gets per wei 
   * @param _wallet Address where collected funds will be forwarded to
   * @param _cap Max amount of wei to be contributed
   * @param _teamWallet Address of the token being sent when finishes
   * @param _novumWallet Address of the token being sent when finishes
   * @param _token Address of the token being sold
   */
  constructor(
    uint256 _openingTime,
    uint256 _closingTime,
    uint256 _preSaleEndTime,
    uint256 _publicSaleStartTime,
    uint256 _rate,
    address _wallet,
    uint256 _cap,
    address _teamWallet,
    address _novumWallet,
    BountieToken _token
  )
    public
    Crowdsale(_rate, _wallet, _token)
    CappedCrowdsale(_cap)
    TimedCrowdsale(_openingTime, _closingTime)
    PreAndPublicSaleCrowdsale(_preSaleEndTime, _publicSaleStartTime)
    DistributableCrowdsale(_teamWallet, _novumWallet)
  {
    
  }

}