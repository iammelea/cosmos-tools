#!/bin/bash
echo "Hello,"
sleep 1
echo "So, let's build our IBC PATH to connect 2 chains via IBC"
sleep 1
echo "Enter chain-id chain #1 example melea-11:"
read CHAIN1
echo "Enter chain-id chain #2 example meleo-22"
read CHAIN2
echo "Enter name for the IBC PATH example: chain1_chain2"
read PATHN

#check chains on relayer
rly ch list

echo " go go go"
#start lite clients
rly lite init -f $CHAIN1
rly l i -f $CHAIN2

#check balances
rly q bal $CHAIN1
rly q bal $CHAIN2

#ask for coins via faucet
rly testnets request $CHAIN1 faucet 
rly tst req $CHAIN2 faucet -u http://127.0.0.1:8001

#check balances
rly q bal $CHAIN1
rly q bal $CHAIN2

rly pth gen $CHAIN1 transfer $CHAIN2 transfer $PATHN

rly tx link $PATHN
