#!/usr/bin/env bash
# btc-rates-daily.sh v1.1.6 - Sunday, April 24, 2022
_me="${0##*/}"

# tail -25 $(find ~/.local/var/log/btc_rates -mtime -1 -name 'btc*log')
grep INFO $(find ~/.local/var/log/btc_rates -mtime -1 -name 'btc*log') \
	| tail -25 \
	| mail -s "BTC Rates Daily" patrick
