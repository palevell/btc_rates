-- Verify btc_rates:daily_price on pg

BEGIN;

SET search_path TO btc_rates;

SELECT	date_id, qty,
	cad_open, cad_close, cad_hi, cad_lo,
	usd_open, usd_close, usd_hi, usd_lo
FROM	daily_price
WHERE	FALSE;

ROLLBACK;
