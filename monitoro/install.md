<p align="center">
  <img width="460" height="460" src="https://meleatrust.com/wp-content/uploads/2020/03/g5738.png">
</p>




Symple but practical bash script where telegram bot send msg with: sync status and peers for the Cosmos nodes you need.
if the node is not running, restart the node and send msg about that action too. 

What do? 1 status node, 2 check if node is not runing then start in case need, 3 send telegram msg.

<p align="center">
  <img width="300" height="600" src="https://meleatrust.com/wp-content/uploads/2020/03/photo_2020-03-07_20-40-20.jpg">
</p>

How to get chat ID and telegram bot [Guide](https://github.com/iammelea/cosmos-tools/blob/master/monitoro/Telegram_bot_token_chatID)



# Install

$ sudo apt update && sudo apt upgrade -y

$ sudo apt install screen curl expect -y

$ git clone https://github.com/iammelea/cosmos-tools.git

$ cd cosmos-tools/monitoro

chose the name of the chain and give permissions to run.


$ chmod +x monitoro.sh

Or

$ chmod +x regen_monitoro.sh


Open and edit your info inside the file

$ vi monitoro.sh

WHAT Info?
<26657> for the RPC port of the node in case is other.

<WRITE-NODE-NAME-HERE>
  
<YOUR_TELEGRAM_TOKEN>

<YOUR_CHAT_ID>

sudo systemctl restart <PROCESS NAME>

Edit times under convenience. 300 is =5 minutes.

Tip: can edit the node name and add you prefers emoticonos too.
  

$ screen -S monitoro

Need run like sudo if used "sudo systemctl" for manage the restart of the node, in case other assistant no need sudo.


$ sudo ./monitoro.sh



setup with systemd for keep running after system restart and tuning under your convenience.

Cheers

