#! /bin/bash

minGas=5500000

gasLimit=$(curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest", true],"id":1}' "${HOME_CHAIN}" | \
    python -c "import sys, json; print(int(json.load(sys.stdin)['result']['gasLimit'], 0))")
    
until [ "$gasLimit" -gt "$minGas" ] ; do
  >&2 echo "Gas limit of ${gasLimit} is too low - sleeping..."
  gasLimit=$(curl -s -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest", true],"id":1}' "${HOME_CHAIN}" | \
      python -c "import sys, json; print(int(json.load(sys.stdin)['result']['gasLimit'], 0))")
  sleep 1
done

>&2 echo "Gas limit (${gasLimit}) is high enough to deploy to!"

truffle migrate --reset
truffle exec scripts/create_config.js --home=$HOME_CHAIN --side=$SIDE_CHAIN --ipfs=$IPFS
