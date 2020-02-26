# bash script telegram bot 1,2,3 = status - if null start- then sync status msg  
while [ "true" ]
    do
        token="<YOUR_TELEGRAM_TOKEN>"
        chat_id="<YOUR_CHAT_ID>"
        tg_api="https://api.telegram.org/bot${token}/sendMessage?chat_id=${chat_id}"

 
        sync_status="true|false"
        status=`gaiacli status | grep -E ${catching_up}`
        if ! pgrep -x "gaiad" > /dev/null
        then
            crash_msg="No response from the node Bro, let's restart this boy. . . 🚀"
            echo $crash_msg
            curl -s "${tg_api}" --data-urlencode "text=${crash_msg}"
            echo -e gaiad start &
            sleep 180
        else
            status_msg="Cosmos sync= ${status}!"
            echo "${status_msg}"
            # Telegram notification
            # If no need to notificate just comment line bellow
            curl -s "${tg_api}" --data-urlencode "text=${status_msg}"
        fi
        sleep 30
            
done

