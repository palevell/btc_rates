-- Deploy btc_rates:dt_price to pg
-- requires: app_schema

BEGIN;

SET search_path TO btc_rates;

CREATE TABLE dt_price (
	id		INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 10001),
	date_id		DATE NOT NULL,
	date_time	TIMESTAMPTZ NOT NULL,
	cad		DECIMAL(10,2) NOT NULL,
	usd		DECIMAL(10,2) NOT NULL
);

CREATE UNIQUE INDEX idx_price_date_time ON dt_price(date_time);
CREATE INDEX idx_price_date_time_d ON dt_price(date_time DESC);
CREATE INDEX idx_price_date_id ON dt_price(date_id);

COMMIT;
