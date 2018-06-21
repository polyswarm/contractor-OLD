from gitlab.polyswarm.io:3343/polyswarm/polyswarm-contracts/polyswarm-contracts:latest

RUN apk add curl
# RUN npm install web3-net

COPY ./scripts ./scripts

CMD ["./scripts/migrate_and_create_config.sh"]
