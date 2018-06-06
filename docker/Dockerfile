#
# Compile contracts to a mounted volume.
# Polyswarmd reads this this volume for subdirs.
# 
FROM ubuntu:17.10

ENV     ROOTDIR="/usr/src/app"
ENV     TRUFFLE="$ROOTDIR/truffle"
ENV     SHARE=""
VOLUME  $TRUFFLE

RUN     mkdir -p $ROOTDIR

WORKDIR $ROOTDIR

#
# Module Installation
#
RUN     apt-get -y update && apt-get install -y \
                                                \
          ruby                                  \
          git                                   \
          curl                                  \ 
          wget                                  \
          build-essential                       \
          gcc                                   \
          g++                                   \
          make                                  \ 
          sudo                                  \ 
          vim                                   \
#         libcurl4-openssl-dev                  \
#         libssl-dev                            \
          net-tools

RUN     curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN     apt-get -y install nodejs # Sine curl required, this is exceptional independent apt-get.
RUN     nodejs -v
RUN     npm -v
RUN     gem install colorize

#
# XXX   somehow clone does not work
#
# RUN     git clone https://github.com/polyswarm/polyswarm-contracts.git
# RUN     mv polyswarm-contracts truffle

COPY    $SHARE/polyswarm-contracts    ./truffle
COPY    $SHARE/scripts/mint_tokens.sh $TRUFFLE/mint_tokens.sh
COPY    $SHARE/scripts/mint_tokens.js $TRUFFLE/mint_tokens.js
COPY    $SHARE/scripts/post_bounty    $TRUFFLE/post_bounty

#
# Contract Compilation 
#
WORKDIR $TRUFFLE
COPY    $SHARE/scripts/truffle-config.js .
RUN     npm install -g truffle
# RUN     npm install node-libcurl --runtime=electron --target=1.0.2 --disturl=https://atom.io/download/atom-shell --arch=x64 --save
#
# XXX update lfs-queenb and locate node_modules
#
# RUN     npm i 
RUN     npm config rm proxy
RUN     npm config rm https-proxy
RUN     truffle compile

#
# Contract Migration part
#
COPY    $SHARE/scripts/migrate.sh /usr/local/bin/migrate
RUN     echo "netstat -ntlp | grep LISTEN" > /usr/local/bin/ports
RUN     chmod +x /usr/local/bin/migrate
RUN     chmod +x /usr/local/bin/ports

RUN     echo $TRUFFLE/migrations
RUN     ls $TRUFFLE/migrations

RUN     mkdir -p /backup
RUN     cp -r $TRUFFLE /backup
RUN     cp /usr/local/bin/migrate $ROOTDIR/migrate
