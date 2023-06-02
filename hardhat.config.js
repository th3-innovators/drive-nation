require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      accounts: [{
        privateKey: "0e5d720dc090ba68e42cefdccb833307f1b043d7f8024d99f007b23ded4d9591",
        balance: "1000000000000000000000"
      }]
    }
  },
  solidity: "0.8.18",
};
