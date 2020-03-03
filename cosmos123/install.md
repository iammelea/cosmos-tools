#This script Install Go+13 + Cosmos + create systemd service and run
#Firewal need 26656 for p2p

$ wget https://raw.githubusercontent.com/iammelea/cosmos-tools/master/cosmos123/cosmos123.sh

$ chmod +x ./cosmos123.sh

$ ./cosmos123.sh


#if everything goes well you will end up seeing the logs of the gaiad service, now you can cut them with Ctrl+c

#Check the logs from the node

$ tail -f /var/log/gaiad/gaiad.log

#Service logs

$ sudo journalctl -u gaiad -f

# cheers
