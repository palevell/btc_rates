-- Deploy btc_rates:dt_daily to pg
-- requires: app_schema

BEGIN;

SET search_path TO btc_rates;

CREATE TABLE dt_daily (
	id		INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 10001),
	date_id		DATE NOT NULL,
	cad_open	DECIMAL(10,2) NOT NULL,
	cad_lo		DECIMAL(10,2) NOT NULL,
	cad_hi		DECIMAL(10,2) NOT NULL,
	cad_range	DECIMAL(10,2) NOT NULL,
	cad_close	DECIMAL(10,2) NOT NULL,
	cad_chg_amt	DECIMAL(10,2) NOT NULL,
	cad_chg_pct	DECIMAL(10,6) NOT NULL,
	usd_open	DECIMAL(10,2) NOT NULL,
	usd_lo		DECIMAL(10,2) NOT NULL,
	usd_hi		DECIMAL(10,2) NOT NULL,
	usd_range	DECIMAL(10,2) NOT NULL,
	usd_close	DECIMAL(10,2) NOT NULL,
	usd_chg_amt	DECIMAL(10,2) NOT NULL,
	usd_chg_pct	DECIMAL(10,6) NOT NULL
);

CREATE UNIQUE INDEX idx_daily_date ON dt_daily(date_id);

COMMIT;
