var HDWalletProvider = require("truffle-hdwallet-provider")
var mnemonic = "mystery dolphin lumber kiwi gallery old isolate scale begin glory barrel coin"

module.exports = {
  networks: {
      development: {
          host: "localhost",
          port: 7545,
          network_id: "*" ,
          gas: 6721975
      },
      rinkeby: {
          provider: function() {
            return new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/cWROvF4DmYYVP2bWfvZO")
          },
          network_id: 4
      }
  }
};