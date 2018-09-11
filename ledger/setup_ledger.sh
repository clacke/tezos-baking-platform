#!/usr/bin/env bash
set -eu

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$DIR"

if ! [ "${1:-X}" = wallet ]; then
    BAKING_APP=Y ./build.sh
    ./install-nix.sh 'Tezos Baking'${2:-}
fi
if ! [ "${1:-X}" = bake ]; then
    BAKING_APP='' ./build.sh
    ./install-nix.sh 'Tezos Wallet'${2:-}
fi
