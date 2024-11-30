-- Deploy btc_rates:daily_change to pg
-- requires: app_schema
-- requires: daily_price
-- requires: dt_daily

BEGIN;

SET search_path TO btc_rates;

CREATE VIEW daily_change AS
SELECT	date_id, 
	cad_open, cad_lo, cad_hi,
	cad_hi - cad_lo AS cad_range,
	cad_close,
	cad_close - cad_open AS cad_chg_amt,
	(cad_close - cad_open) * 100 / cad_open AS cad_chg_pct,
	usd_open, usd_lo, usd_hi,
	usd_hi - usd_lo AS usd_range,
	usd_close,
	usd_close - usd_open AS usd_chg_amt,
	(usd_close - usd_open) * 100 / usd_open AS usd_chg_pct 
FROM	daily_price dp;

COMMIT;
