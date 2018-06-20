from polyswarm/contracts:latest

RUN apk add curl

COPY ./scripts ./scripts

CMD ["./scripts/migrate_and_create_config.sh"]
