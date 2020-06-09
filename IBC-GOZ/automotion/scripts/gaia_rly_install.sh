#!/bin/bash
#here we go
command -v go >/dev/null 2>&1 || { echo >&2 "Here require Goland aKa GO but it's not installed or GOPATH is not oke. check ~/cosmos-tools/ibc/scripts and Install goland, Now  Aborting."; exit 1; }

#install gaia & relayer

git clone https://github.com/cosmos/gaia && cd gaia && git checkout goz-phase-2 && make install && gaiad version --long
cd
git clone https://github.com/iqlusioninc/relayer && cd relayer && git checkout v0.5.4 && make install && rly version
cd
