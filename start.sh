#!/bin/sh

geth --datadir ./root/.ethereum/node init /root/.config/genesis.json
geth --config /root/.config/config.toml --datadir ./root/.ethereum/node --pprofaddr 0.0.0.0 --metrics --pprof

