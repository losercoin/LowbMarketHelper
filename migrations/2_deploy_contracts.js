const LowbMarketHelper = artifacts.require("LowbMarketHelper");

module.exports = function(deployer) {
  const lowbMarketAddress = '0xbB82bb854A0Ad088796ed39eB67F0F49781dc9A2';
  deployer.deploy(LowbMarketHelper, lowbMarketAddress);
};
