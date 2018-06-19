#! /bin/bash

say(){
    echo "============================================="
    echo $(IFS=$'\n' ; echo "$@")
    echo "============================================="
}

progress(){
    END=30
    for i in $(seq 1 $END); do
        echo "."
        sleep 1
    done
}

cur_gas_limit(){
    limit=$(truffle migrate --reset)
    if [[ $limit = *"exceeds block gas limit"* ]]; then
        curl -s -i -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest", true],"id":1}' "http://geth:8545"
        echo "Gas is not sufficient. Hold on ... "
        progress
        cur_gas_limit
    else
        echo "Migration Success!"
        truffle exec scripts/create_config.js --home=http://geth:8545 --side=http://sidechain:8545 --ipfs=http://ipfs:4001
    fi
}

cur_gas_limit
