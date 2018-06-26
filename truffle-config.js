require('babel-register');
require('babel-polyfill');
module.exports = {
  networks: {
    development: {
      host: process.env.geth || '0.0.0.0',
      port: 8545,
      network_id: '*',
      gas: 9000000,
    },
    rinkeby: {
      host: 'localhost',
      port: 8545,
      network_id: '4',
      gas: 9000000,
    },
    mainnet: {
      host: 'localhost',
      port: 8545,
      network_id: '1',
      gas: 9000000,
    },
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
};
