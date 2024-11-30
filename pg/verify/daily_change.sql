-- Verify btc_rates:daily_change on pg

BEGIN;

SET search_path TO btc_rates;

SELECT	date_id,
	cad_open, cad_lo, cad_hi, cad_range, cad_close, cad_chg_amt, cad_chg_pct,
	usd_open, usd_lo, usd_hi, usd_range, usd_close, usd_chg_amt, usd_chg_pct 
FROM	daily_change
WHERE FALSE;

ROLLBACK;
