
# bash script where telegram bot send status of the sync for the XRN node
# 1 status node, 2 check if node is not runing then start in case need, 3 send telegram msg.

# Steps install

$ sudo apt update && sudo apt upgrade -y

$ sudo apt install curl expect -y

$ git clone https://github.com/iammelea/cosmos-tools.git

$ cd cosmos-tools/monitoro

$ chmod +x regen_status_start_msg.sh

$ vi regen_status_start_msg.sh

#Edit

#token="<YOUR_TELEGRAM_TOKEN>"
#chat_id="<YOUR_CHAT_ID>"

# https://github.com/iammelea/cosmos-tools/blob/master/monitoro/Telegram_bot_token_chatID

$ Screen -S regen.monitor

$ ./regen_status_start_msg.sh

# setup with systemd for keep running after system restart and tuning under your convenience.





