
# Bitcoin-Price-Monitoring-Telegram-Bot
![image](https://github.com/user-attachments/assets/4dcb47b3-8554-4c63-9d23-4e92ed5113e2)
## Descrição

Este é um bot automatizado para o Telegram que monitora os preços do Bitcoin usando a API da CoinGecko e envia atualizações periódicas para um chat especificado. O bot também calcula a variação percentual do preço em relação ao fechamento anterior.

----------

## Funcionalidades

-   Consulta automática dos preços do Bitcoin em intervalos regulares.
-   Cálculo da variação percentual em relação ao preço anterior.
-   Envio de mensagens personalizadas para um grupo ou canal do Telegram.
-   Gerenciamento de erros em caso de falha na API.

----------

## Tecnologias Utilizadas

-   **Bash**: Para o script de automação.
-   **CoinGecko API**: Para obter os preços do Bitcoin.
-   **Telegram Bot API**: Para enviar mensagens para o Telegram.
-   **jq**: Para manipular JSON no script.

----------

## Configuração

### Pré-requisitos

-   **curl**: Para realizar requisições HTTP.
-   **jq**: Para processar dados JSON.
-   Token do bot do Telegram e chat ID configurados.
