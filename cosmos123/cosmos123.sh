#!/bin/bash
# Install Go+13 + Cosmos + create systemd service and run by melea "Genesis Cosmos Validator"

USER=$(whoami)
sudo apt-get update
sudo apt install build-essential
wget https://dl.google.com/go/go1.13.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.13.linux-amd64.tar.gz
echo 'GOPATH="$HOME/go"' >> $HOME/.profile
echo 'PATH="$GOPATH/bin:$PATH"' >> $HOME/.profile
echo 'PATH="$PATH:/usr/local/go/bin"' >> $HOME/.profile
source $HOME/.profile
git clone https://github.com/cosmos/gaia.git
cd gaia
git checkout v2.0.3
make install
gaiad init Node-Name-here --chain-id cosmoshub-3
sleep 1
gaiad version --long
sleep 1
sudo chmod -R 777 .gaiad
cd ~/.gaiad/config/
rm genesis.json
wget https://raw.githubusercontent.com/cosmos/launch/master/genesis.json
cd
sed -E -i 's/persistent_peers = \".*\"/persistent_peers = \"75d0bb3eb9a76dbd77467934008de2c338b2f2ac@51.68.162.219:26656,a4396a9d621dad287124da4f8861bd8d5fd99a69@3.123.47.143:26656,1e63e84945837b026f596ed8ae68708783d04ad4@51.75.145.123:26656,e4f5becb53b568bfd18c7f086dada943f768bc7a@34.244.129.193:26656,94375d3642bf7366bb50f1d91dbeda70b013e6a1@34.255.217.37:26656,aacf186a5a711b1fe511a25e451c1ddbce2d8e4b@8.9.4.245:26656\"/' ~/.gaiad/config/config.toml
sed -E -i 's/minimum-gas-prices = \".*\"/minimum-gas-prices = \"0.025uatom\"/' ~/.gaiad/config/app.toml
sudo mkdir -p /var/log/gaiad
sudo touch /var/log/gaiad/gaiad.log
sudo touch /var/log/gaiad/gaiad_error.log
cat <<EOF > gaiad.service
[Unit]
Description=gaiad daemon
After=network-online.target

[Service]
ExecStart=/home/$USER/go/bin/gaiad start --home=/home/$USER/.gaiad/
StandardOutput=file:/var/log/gaiad/gaiad.log
StandardError=file:/var/log/gaiad/gaiad_error.log
Restart=always
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF

sudo mv gaiad.service /etc/systemd/system

sudo systemctl daemon-reload
sudo systemctl enable gaiad
sudo systemctl start gaiad
sleep 2
tail -f /var/log/gaiad/gaiad.log
