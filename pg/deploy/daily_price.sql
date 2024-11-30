-- Deploy btc_rates:daily_price to pg
-- requires: app_schema
-- requires: dt_price

BEGIN;

SET search_path TO btc_rates;

CREATE VIEW daily_price AS
SELECT DISTINCT date_id,
	COUNT(date_time) OVER(PARTITION BY date_id) AS qty,
	FIRST_VALUE(cad) OVER(PARTITION BY date_id ORDER BY date_time) AS cad_open,
	MIN(cad) OVER(PARTITION BY date_id) AS cad_lo,
	MAX(cad) OVER(PARTITION BY date_id) AS cad_hi,
	FIRST_VALUE(cad) OVER(PARTITION BY date_id ORDER BY date_time DESC) AS cad_close,
	FIRST_VALUE(usd) OVER(PARTITION BY date_id ORDER BY date_time) AS usd_open,
	MIN(usd) OVER(PARTITION BY date_id) AS usd_lo,
	MAX(usd) OVER(PARTITION BY date_id) AS usd_hi,
	FIRST_VALUE(usd) OVER(PARTITION BY date_id ORDER BY date_time DESC) AS usd_close
FROM	dt_price
ORDER BY date_id;

COMMIT;
