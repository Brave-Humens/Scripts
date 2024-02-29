#!/bin/bash
my_chat_id="ChangeMe"  # https://t.me/userinfobot
bot_id="ChangeMe"  # https://t.me/BotFather
accountId="ChangeMe"  # For example: st7aRUx17s68YZBzxVt7qHC3YYYWPanSXAhWhqBQtHKwtPG1R
Node_name="ChangeMe"

function send_to_tg () {
        curl -X POST --connect-timeout 10 "https://api.telegram.org/bot$bot_id/sendMessage" -d chat_id=$my_chat_id -d parse_mode="Markdown" -d text="$text"
}

total=$(curl 'https://subspace.webapi.subscan.io/api/scan/account/tokens' \
  -H 'authority: subspace.webapi.subscan.io' \
  -H 'accept: application/json' \
  -H 'accept-language: ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7,de;q=0.6' \
  -H 'content-type: application/json' \
  -H 'origin: https://subspace.subscan.io' \
  -H 'referer: https://subspace.subscan.io/' \
  -H 'sec-ch-ua: "Chromium";v="122", "Not(A:Brand";v="24", "Google Chrome";v="122"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-site' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36' \
  --data-raw "{\"address\":\"$accountId\"}" | jq -r .data.native[].balance)

convert_to_currency() {
  amount=$1
  string=$(echo "scale=2; $amount / 10^18" | bc)
        echo $string
}

converted=$(convert_to_currency $total)
text=$(echo "On $Node_name Subspace tokens is: $converted")
send_to_tg
