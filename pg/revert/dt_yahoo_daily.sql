-- Revert btc_rates:dt_yahoo_daily from pg

BEGIN;

SET search_path TO btc_rates;

DROP TABLE dt_yahoo_daily;

COMMIT;
