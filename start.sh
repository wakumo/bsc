#!/bin/sh

geth --datadir ./root/.ethereum/node init genesis.json
geth --config ./config.toml --datadir ./root/.ethereum/node --pprofaddr 0.0.0.0 --metrics --pprof

