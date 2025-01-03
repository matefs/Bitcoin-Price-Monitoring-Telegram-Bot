#!/bin/bash
export TELEGRAM_BOT_TOKEN="your_bot_token"
export TELEGRAM_CHAT_ID="your_chat_id"


while true; do
    url_market_chart="https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=1"
    resposta_api=$(curl -s "$url_market_chart")

    preco_fechamento_anterior_bruto=$(echo "$resposta_api" | jq -r '.prices[0][1]')
    preco_atual_bruto=$(echo "$resposta_api" | jq -r '.prices[-1][1]')

    if [[ -z "$preco_atual_bruto" || -z "$preco_fechamento_anterior_bruto" || "$preco_atual_bruto" == "null" || "$preco_fechamento_anterior_bruto" == "null" ]]; then
        echo "Erro ao obter preços. Tentando novamente em 30 minutos..."
        sleep 1800
        continue
    fi

    variacao_percentual_bruta=$(echo "scale=4; (($preco_atual_bruto - $preco_fechamento_anterior_bruto) / $preco_fechamento_anterior_bruto) * 100" | bc)
    if [[ -z "$variacao_percentual_bruta" || "$variacao_percentual_bruta" == *"error"* ]]; then
        echo "Erro ao calcular a variação. Tentando novamente em 30 minutos..."
        sleep 1800
        continue
    fi

    preco_fechamento_anterior=$(LC_NUMERIC=C printf "%.2f" "$preco_fechamento_anterior_bruto")
    preco_atual=$(LC_NUMERIC=C printf "%.2f" "$preco_atual_bruto")
    variacao_percentual=$(LC_NUMERIC=C printf "%.2f" "$variacao_percentual_bruta")

    preco_fechamento_anterior=$(echo "$preco_fechamento_anterior" | sed 's/\./,/g')
    preco_atual=$(echo "$preco_atual" | sed 's/\./,/g')
    variacao_percentual=$(echo "$variacao_percentual" | sed 's/\./,/g')

    echo "Preço atual do Bitcoin: \$ $preco_atual"
    echo "Preço de fechamento anterior (primeira cotação do período): \$ $preco_fechamento_anterior"
    echo "Variação percentual: $variacao_percentual%"

    bot_token="${TELEGRAM_BOT_TOKEN}"
    chat_id="${TELEGRAM_CHAT_ID}"
    mensagem="Preço atual: \$ $preco_atual
Variação percentual: $variacao_percentual%
Fechamento anterior: \$ $preco_fechamento_anterior"

    curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" \
        -d "chat_id=$chat_id" \
        -d "text=$mensagem"

    sleep 1800
done
