# bash script Cosmos Monitor with telegram msg.→ what do? =  send telegram msg with status + peers then check if the node is not running restart + msg telegram 
#EDIT where: 26657 for your RPC port if it is a different one. + <YOUR_TELEGRAM_TOKEN> + <YOUR_CHAT_ID> + <WRITE-NODE-NAME-HERE> + <sudo systemctl <PROCESS NAME> ???>
while [ "true" ]
    do
        token="<YOUR_TELEGRAM_TOKEN>"
        chat_id="<YOUR_CHAT_ID>"
        tg_api="https://api.telegram.org/bot${token}/sendMessage?chat_id=${chat_id}"
        status=`curl http://localhost:26657/status | grep -E catching_up`
        peers=`curl  http://localhost:26657/net_info | grep -E n_peers`
            status_msg="⚛️   <WRITE-NODE-NAME-HERE>:  🔖    ${peers} & ${status} ⛏⚙️"
            echo "${status_msg}"
            curl -s "${tg_api}" --data-urlencode "text=${status_msg}" &
        if ! curl http://localhost:26657/status > /dev/null
        then
            crash_msg="☢️Hum, <WRITE-NODE-NAME-HERE> is Not running☢️. Restarting now‼️ . . 🚀"
            echo $crash_msg
            curl -s "${tg_api}" --data-urlencode "text=${crash_msg}"
            rst=`sudo systemctl restart <PROCESS NAME>`
            echo $rst  &
        fi
            sleep 1800

    done
