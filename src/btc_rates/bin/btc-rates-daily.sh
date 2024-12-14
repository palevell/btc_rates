#!/usr/bin/env bash
# btc-rates-daily.sh v1.2.19 - Sunday, April 24, 2022
_me="${0##*/}"

set -eu

YM=$(date +%Y-%m -d 'yesterday')
YMD=$(date -I -d 'yesterday')
HOST=cron.servarica
LOCAL_DIR=~/.local/var/log/btc_rates
REMOTE_DIR=${HOST}:.local/var/log/btc_rates
MSG_FILE=${LOCAL_DIR}/.msg-${YMD}.msg

scp -pq ${REMOTE_DIR}/btc_rates_${YM}.log ${LOCAL_DIR}/btc_rates+${YM}-vps.log
LOGFILES=$(find ~/.local/{state/LevellTech,var/log}/btc_rates -name "btc_rates*log" -mtime -1)
grep -h ${YMD} $LOGFILES | grep "get_prices INFO" | sort -u >$MSG_FILE

cat $MSG_FILE | mail -s "BTC Rates for ${YMD} (via blockchain.info)" patrick

# LOGFILE=~/.local/var/log/btc_rates/btc_rates_$(date +%Y-%m).log
# grep -h INFO $LOGFILES | tail -25 | mail -s "BTC Rates Daily" patrick

## This section is from psql-btc.sh
_stem="${_me%.*}"

TSFILE=$(mktemp ${TMP-/tmp}/${_stem}-XXXXX.ts)
TS=$(date +%Y%m%d_%H%M%S)
# L=${TMP-/tmp}/${_stem}_${TS}.log
# OH=${TMP-/tmp}/${_stem}_${TS}.html
# OC=${TMP-/tmp}/${_stem}_${TS}.csv
OT=${TMP-/tmp}/${_stem}_${TS}.txt

touch $TSFILE

NUM_DAYS=15
DATE_FROM=$(date -I -d "${NUM_DAYS} days ago")
# psql -AH -L $L -o $OH <<-EOT
psql -AXF$'\t' -o $OT <<-EOT
	SELECT	date_id AS "== Date ==     ",
		max(CASE WHEN symbol = 'BTC-CAD' THEN to_char(price, '99999G999D00') ELSE NULL END) "  === CAD ===",
		max(CASE WHEN symbol = 'BTC-USD' THEN to_char(price, '99999G999D00') ELSE NULL END) "  === USD ==="
	FROM	btc_rates.dt_yahoo_daily
	WHERE	symbol LIKE 'BTC-%'
	  AND	date_id >= '${DATE_FROM}'
	GROUP BY date_id
	ORDER BY date_id;
EOT

# find -type l -name "${_stem}.*" -delete

SUBJ_DATE=$(date "+%B %d, %Y" -d "yesterday")
SUBJ="${NUM_DAYS}-Day BTC Prices  ${SUBJ_DATE}"  # (via Yahoo! Finance)"
# [ $OC -nt $TSFILE ] && cat $OC
# [ $OH -nt $TSFILE ] && w3m -T text/html $OH
[ $OT -nt $TSFILE ] && cat $OT | mail -s "$SUBJ" $USER

rm $TSFILE $OT
