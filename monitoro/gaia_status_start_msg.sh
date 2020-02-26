# bash script telegram bot 1,2,3 = Cosmos SDK nodes→ status - if null→ start- then sync status msg. by melea
while [ "true" ]
    do
        token="<YOUR_TELEGRAM_TOKEN>"
        chat_id="<YOUR_CHAT_ID>"
        tg_api="https://api.telegram.org/bot${token}/sendMessage?chat_id=${chat_id}"

 
        catching_up="true|false"
        status=`curl localhost:26657/status | grep -E ${catching_up}`
        if ! pgrep -x "gaiad" > /dev/null
        then
            crash_msg="Ups! node is gone, let's start this boy. . . 🚀"
            echo $crash_msg
            curl -s "${tg_api}" --data-urlencode "text=${crash_msg}"
            echo -e gaiad start &
            sleep 1800
        else
            status_msg="Cosmos sync= ${status}!"
            echo "${status_msg}"
            # Telegram msg
            # If no want msg uncoment next line.
            curl -s "${tg_api}" --data-urlencode "text=${status_msg}"
        fi
        sleep 900
            
done

