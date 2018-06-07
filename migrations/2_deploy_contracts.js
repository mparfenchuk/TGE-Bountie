const BountieCrowdsale = artifacts.require("./BountieCrowdsale.sol");
const BountieToken = artifacts.require("./BountieToken.sol");

module.exports = function(deployer, network, accounts) {
    
    //["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul","Aug", "Sep", "Oct", "Nov", "Dec"];
    const openingTime = Date.parse('07 Jun 2018 15:00 GMT')/1000;
    const closingTime = Date.parse('20 Jul 2018 15:00 GMT')/1000;
    const preSaleEndTime = Date.parse('19 Jun 2018 15:00 GMT')/1000;
    const publicSaleStartTime = Date.parse('20 Jun 2018 15:00 GMT')/1000;
    const rate = new web3.BigNumber(4000); 
    const cap = web3.toWei('37500', 'ether');
    const wallet = '0xc5468a0576444026c734614cb59f5f173d5e8a6d';
    const teamWallet = '0x8a2627b90b91ab6d3388a4d23f5400d9f40c412e';
    const novumWallet = '0x6c0721590b9bba886c9db74a85ac2e19c16686db';

    return deployer
        .then(() => {
            return deployer.deploy(BountieToken);
        })
        .then((instance) => {
            return instance.pause();
        })
        .then(() => {
            return deployer.deploy(BountieCrowdsale, openingTime, closingTime, preSaleEndTime, publicSaleStartTime, rate, wallet, cap, teamWallet, novumWallet, BountieToken.address);
        })
        .then (() => {
            return BountieToken.deployed();
        })
        .then((instance) => {
            return instance.transferOwnership(BountieCrowdsale.address);
        });
       
}