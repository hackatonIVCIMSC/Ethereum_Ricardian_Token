var SimpleStorage = artifacts.require("./SimpleStorage.sol");
//var CIMSToken = artifacts.require("./CIMSToken.sol");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  //deployer.deploy(CIMSToken);
};
