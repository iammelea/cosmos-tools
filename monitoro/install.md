
#Symple but practical bash script where telegram bot send msg with: sync status and peers of the sync for the Cosmos nodes you need.
#if not running, start the node and send msg about that action too. Edit times under convenience. 300 is =5 minutes.

#What do? 1 status node, 2 check if node is not runing then start in case need, 3 send telegram msg.

# Install

$ sudo apt update && sudo apt upgrade -y

$ sudo apt install screen curl expect -y

$ git clone https://github.com/iammelea/cosmos-tools.git

$ cd cosmos-tools/monitoro

#chose the name of the chain and give permissions to run.
#https://github.com/iammelea/cosmos-tools/tree/master/monitoro

$ chmod +x 13007_monit.sh

Or

$ chmod +x iris_monit.sh


#open and add your telegram data

$ vi xrn_monit.sh

#Or example

$ vi iris_monit.sh

#Edit

#token="<YOUR_TELEGRAM_TOKEN>"
#chat_id="<YOUR_CHAT_ID>"

#Tip: can edit the node name where Regen / Iris / 13007 / and more

https://github.com/iammelea/cosmos-tools/blob/master/monitoro/Telegram_bot_token_chatID

$ Screen -S monitoro

$ ./iris_monit.sh

#Or for cosmos testnet, remember chose the same you add your telegram data

$ ./13007-monit.sh

#setup with systemd for keep running after system restart and tuning under your convenience.

#Cheers

