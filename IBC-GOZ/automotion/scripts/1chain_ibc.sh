#!/bin/bash
#here we go
command -v pm2 >/dev/null 2>&1 || { echo >&2 "Require PM2 but it's not installed!!! check ~/cosmos-tools-ibc/scripts and Install PM2, Now Aborting."; exit 1; }
command -v gaiad >/dev/null 2>&1 || { echo >&2 "Require gaia aKa Cosmos software but it's not installed!!! check ~/cosmos-tools/ibc/scripts and Install goland, Now  Aborting."; exit 1; }


echo "Hello,"
sleep 1
echo "So, let's build our first network to connect them via IBC"
sleep 1
echo "Build and open one faucet for your chain too."
sleep 1
echo "OK, lets go"
sleep 2
echo "Enter keyring passphrase <password must be at least 8 characters, only letters and numbers>:"
read password
echo "Enter Token name example: abtc ok, ABTC NO ok"
read DENOM
echo "Enter 2 Token name example: aeth ok, AETH NO ok"
read DENOM2
echo "Enter chain-id example: melea-11"
read CHAINID
echo "Enter Domain name example: ibc.domain.com, if no domain localhost"
read DOMAIN
echo "Enter node name aka moniker: example validator1"
read MONIKER
echo "Enter RPC port example 36657:"
read RPC
echo "Enter P2P port example 36656:"
read P2P
echo "Enter faucet port  example 8000:"
read FCT
echo "Enter dir name for gaia chain example .ibcgaia:"
read DIR




export RLYKEY=faucet
export ACCOUNT_PREFIX=cosmos

#Create chain.json
echo "{\"key\":\"$RLYKEY\",\"chain-id\":\"$CHAINID\",\"rpc-addr\":\"http://$DOMAIN:$RPC\",\"account-prefix\":\"$ACCOUNT_PREFIX\",\"gas\":200000,\"gas-prices\":\"0.025$DENOM\",\"default-denom\":\"$DENOM\",\"trusting-period\":\"330h\"}" > $CHAINID.json


rly config init 
rly chains add -f $CHAINID.json 
rly keys add $CHAINID $RLYKEY 

echo "Important!!!"
sleep 2
echo "NOTE:"
sleep 2

echo "Now write this mnemonic phrase for FAUCET key in a safe place."
sleep 2

echo "The 12 words are the only way to recover your account if you ever forget your password"
sleep 2

#Build cosmos chain 3,2.1
gaiad init --chain-id $CHAINID $MONIKER --home ~/$DIR
sed -i 's#tcp://127.0.0.1:26657#tcp://0.0.0.0:'"${RPC}"'#g' ~/$DIR/config/config.toml
sed -i 's#tcp://0.0.0.0:26656#tcp://0.0.0.0:'"${P2P}"'#g' ~/$DIR/config/config.toml
sed -i "s/\"stake\"/\"$DENOM\"/g" ~/$DIR/config/genesis.json
sed -i 's/pruning = "syncable"/pruning = "nothing"/g' ~/$DIR/config/app.toml

echo "gaiacli keys add validator, enter password"
sleep 3

gaiacli keys add validator --home ~/$DIR

echo "Important!!!"
sleep 2
echo "NOTE:"
sleep 2

echo "Now write this mnemonic phrase for VALIDATOR key in a safe place."
sleep 2

echo "The 12 words are the only way to recover your account if you ever forget your password"
sleep 2

#genesis file

echo "gaiad adding genesis account Validator"
echo "${password}" | echo "${password}" | gaiad add-genesis-account $(gaiacli keys show validator -a) 100000000000000$DENOM,100000000000000$DENOM2 --home ~/$DIR
echo "done!"
sleep 3

echo "gaiad adding genesis account Faucet"
echo "${password}" | echo "${password}" | gaiad add-genesis-account $(rly chains addr $CHAINID) 100000000000000$DENOM,100000000000000$DENOM2 --home $DIR
echo "done!"
sleep 3

echo "gaiad create gentx validator, be ready to confirm password 3 times"
gaiad gentx --name validator --amount 100000000000$DENOM --home ~/$DIR
echo "done!"
sleep 3

echo "gaiad collect gentx"
gaiad collect-gentxs --home ~/$DIR
echo "done!"

#pm2 start script
cat <<EOF > $CHAINID.sh
#!/bin/bash
gaiad start --home ~/$DIR
EOF
chmod +x $CHAINID.sh
pm2 start $CHAINID.sh

#pm2 faucet relayer script
cat <<EOF > $CHAINID\faucet.sh
#!/bin/bash
rly testnets faucet $CHAINID faucet 100000000$DENOM --listen 0.0.0.0:$FCT
EOF
chmod +x $CHAINID\faucet.sh
pm2 start $CHAINID\faucet.sh
pm2 ls
sleep 5
echo "cut logs with CRTL+C, visit https://github.com/Unitech/pm2 for pm2 cmds"
sleep 3
pm2 monit
