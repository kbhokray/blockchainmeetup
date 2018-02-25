var LangViz = artifacts.require("./LangViz.sol");

module.exports = function(deployer) {
  	deployer.deploy(LangViz, 100/*, {gas: 6000000}*/)
    /*.then(function() {
  		return deployer.deploy(DependentToken, LangViz.address);
    });*/
};