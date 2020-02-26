# bash script telegram bot 1,2,3 = Cosmos SDK nodes→ status - if null→ start- then sync status msg. by melea
while [ "true" ]
    do
        token="<WRITE-YOUR_TELEGRAM_TOKEN>"
        chat_id="<WRITE-YOUR_CHAT_ID>"
        tg_api="https://api.telegram.org/bot${token}/sendMessage?chat_id=${chat_id}"

 
        catching_up="true|false"
        status=`curl localhost:26657/status | grep -E ${catching_up}`
        if ! pgrep -x "xrnd" > /dev/null
        then
            crash_msg="UPS! node is not working, let's start this boy. . . 🚀 "
            echo $crash_msg
            curl -s "${tg_api}" --data-urlencode "text=${crash_msg}"
            echo -e screen -S regen && xrnd start &
            sleep 1800
        else
            status_msg="REGEN sync: ${status}!"
            echo "${status_msg}"
            # Telegram notification
            # If no need to notificate just comment line bellow
            curl -s "${tg_api}" --data-urlencode "text=${status_msg}"
        fi
        sleep 900

done        
