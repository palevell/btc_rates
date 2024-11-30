-- Revert btc_rates:dt_price from pg

BEGIN;

SET search_path TO btc_rates;

DROP TABLE dt_price;

COMMIT;
