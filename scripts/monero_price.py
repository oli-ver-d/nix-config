#!/usr/bin/env nix-shell
#!nix-shell -i python3 -p "python3.withPackages(ps: [ps.requests])"

import requests
import os
import json

# Constants
API_URL = "https://api.coingecko.com/api/v3/simple/price?ids=monero&vs_currencies=gbp"
CACHE_FILE = "/tmp/xmr_last_price"

# Fetch current price
try:
    response = requests.get(API_URL, timeout=5)
    response.raise_for_status()
    price = response.json()["monero"]["gbp"]
except Exception as e:
    print(json.dumps({
        "text": "XMR: error",
        "tooltip": f"Error fetching price: {e}",
        "markup": "pango"
    }))
    exit(1)

# Determine previous price
last_price = None
if os.path.exists(CACHE_FILE):
    try:
        with open(CACHE_FILE, "r") as f:
            last_price = float(f.read().strip())
    except:
        pass

# Save new price for next run
with open(CACHE_FILE, "w") as f:
    f.write(str(price))

# Arrow selection with % change logic
arrow = "<span color='gray'>→</span>"

if last_price:
    change = price - last_price
    percent = (change / last_price) * 100 if last_price != 0 else 0

    if change > 0:
        arrow = "<span color='green'>▲</span>" if percent >= 1 else "<span color='green'>▴</span>"
    elif change < 0:
        arrow = "<span color='red'>▼</span>" if abs(percent) >= 1 else "<span color='red'>▾</span>"

# Output for Waybar
print(json.dumps({
    "text": f" £{price:.2f}{arrow}",
    "tooltip": f"Monero price in GBP: £{price:.2f}",
    "markup": "pango"
}))
