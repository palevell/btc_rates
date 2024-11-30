#!/usr/bin/env bash
# btc-rates-daily.sh v1.1.7 - Sunday, April 24, 2022
_me="${0##*/}"

LOGFILE=~/.local/var/log/btc_rates/btc_rates_$(date +%Y-%m).log

grep INFO $LOGFILE | tail -25 | mail -s "BTC Rates Daily" patrick
