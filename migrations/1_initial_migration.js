const Mayoral = artifacts.require("MayoralToken");

module.exports = function (deployer) {
  const name = "MayoralToken";
  const symbol ="MAYOGG" ;
  const decimal = 1;
const supply = 100000;
  deployer.deploy(Mayoral,name,symbol,decimal,supply);
};
