const Ballot = artifacts.require("Ballot");

module.exports = function (deployer) {
  deployer.deploy(Ballot, "uber goober");
};

// module.exports = function (deployer) {
//   deployer.deploy(Ballot, "uber goober").then( () => {
//     let instance = await Ballot.deployed();
//   });
// };
