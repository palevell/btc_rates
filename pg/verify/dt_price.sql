-- Verify btc_rates:dt_price on pg

BEGIN;

SET search_path TO btc_rates;

SELECT date_id, date_time, cad, usd
FROM dt_price dp 
WHERE FALSE;

ROLLBACK;
