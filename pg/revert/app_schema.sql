-- Revert btc_rates:app_schema from pg

BEGIN;

DROP SCHEMA btc_rates;

COMMIT;
