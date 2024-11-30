-- Revert btc_rates:daily_change from pg

BEGIN;

SET search_path TO btc_rates;

DROP VIEW daily_change;

COMMIT;
