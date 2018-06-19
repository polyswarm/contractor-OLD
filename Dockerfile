from gitlab.polyswarm.io:3343/polyswarm/polyswarm-contracts/polyswarm-contracts:latest

COPY ./scripts ./scripts

#
# NOTES: cannot install web3 via npm so switched to yarn
# 
RUN apk add curl jq g++ make yarn
RUN yarn add web3 args-parser

CMD ["./scripts/migrate_and_create_config.sh"]
