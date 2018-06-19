#! /bin/bash

say(){
    echo "============================================="
    echo $(IFS="\n" ; echo "$@")
    echo "============================================="
}

# cur_gas_limit(){
#     limit=$(truffle migrate --reset)
#     say $limit
#     cur_gas_limit
# }
# 
# sleep 10
# cur_gas_limit

truffle migrate --reset
truffle exec scripts/create_config.js --home=http://geth:8545 --side=http://sidechain:8545 --ipfs=http://ipfs:4001
