from gitlab.polyswarm.io:3343/polyswarm/polyswarm-contracts/polyswarm-contracts:latest

RUN apk add curl

COPY ./scripts ./scripts

CMD ["./scripts/migrate_and_create_config.sh"]
