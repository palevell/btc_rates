-- Revert btc_rates:daily_price from pg

BEGIN;

SET search_path TO btc_rates;

DROP VIEW daily_price;

COMMIT;
