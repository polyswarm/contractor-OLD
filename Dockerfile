from gitlab.polyswarm.io:3343/polyswarm/polyswarm-contracts/polyswarm-contracts:latest

COPY ./scripts ./scripts

RUN apk add curl jq

CMD ["./scripts/migrate_and_create_config.sh"]
