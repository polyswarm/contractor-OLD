#! /bin/bash

cur_gas_limit(){
    limit=$(curl -i -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest", true],"id":1}' "http://0.0.0.0:8545")
    echo $limit
    sleep 1
    cur_gas_limit
    return limit
}

cur_gas_limit

# truffle migrate --reset
# truffle exec scripts/create_config.js --home=http://geth:8545 --side=http://sidechain:8545 --ipfs=http://ipfs:4001
