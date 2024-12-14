-- Verify btc_rates:dt_yahoo_daily on pg

BEGIN;

SET search_path TO btc_rates;

SELECT	symbol, date_id, price
FROM	dt_yahoo_daily
WHERE FALSE;

ROLLBACK;
