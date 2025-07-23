#!/usr/bin/env bash

# Fetch XMR price in GBP from CoinGecko
response=$(curl -s "https://api.coingecko.com/api/v3/simple/price?ids=monero&vs_currencies=gbp")

# Extract GBP price using jq
if command -v jq &>/dev/null; then
    price=$(echo "$response" | jq -r '.monero.gbp')
else
    # Fallback if jq is not installed
    price=$(echo "$response" | grep -oP '"gbp":\K[0-9.]+')
fi

# Output for Waybar (JSON format)
echo "{\"text\": \"£${price}\", \"tooltip\": \"Monero price in GBP\"}"

