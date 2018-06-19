#! /bin/bash

say(){
    echo "============================================="
    echo $1
    echo "============================================="
}

cur_gas_limit(){
    limit=$(truffle migrate --reset)
    say $limit
    sleep 2
    cur_gas_limit
}

cur_gas_limit

# truffle migrate --reset
# truffle exec scripts/create_config.js --home=http://geth:8545 --side=http://sidechain:8545 --ipfs=http://ipfs:4001
