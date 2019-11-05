#!/bin/bash
pip install  ecdsa
pip install  pysha3 >= 1.0.2

ehco "genesis_accounts="genesis.toml" >> ./run/default.toml

./target/release/conflux --config ./run/conflux.conf --public-address 127.0.0.1:14629 
