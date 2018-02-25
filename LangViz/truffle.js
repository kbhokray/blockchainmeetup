// const HDWalletProvider = require('truffle-hdwallet-provider');

const mnemonic = 'seed mnenomic words';

module.exports = {
  networks: {
    "development": {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    }/*,
    "infura_ropsten": {
      provider: new HDWalletProvider(mnemonic, 'https://ropsten.infura.io/INFURA_API_KEY'),
      gas: 6000000,
      gasPrice: 100000000000,
      network_id: 3
    },
    "infura_rinkeby": {
      provider: new HDWalletProvider(mnemonic, 'https://rinkeby.infura.io/INFURA_API_KEY'),
      gasPrice: 10000000000,
      network_id: 4
    },
    "infura_kovan": {
      provider: new HDWalletProvider(mnemonic, 'https://kovan.infura.io/INFURA_API_KEY'),
      gasPrice: 10000000000,
      network_id: 42
    }*/
  }
};
