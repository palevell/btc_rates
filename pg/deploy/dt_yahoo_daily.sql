-- Deploy btc_rates:dt_yahoo_daily to pg
-- requires: app_schema

BEGIN;

SET search_path TO btc_rates;

CREATE TABLE dt_yahoo_daily (
	id		INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1000001),
	date_id		DATE NOT NULL,
	symbol		VARCHAR(10) NOT NULL,
	price		DECIMAL(20,6) NOT NULL
);

CREATE UNIQUE INDEX idx_yahoo_daily_symbol_date ON dt_yahoo_daily(symbol, date_id);
CREATE INDEX idx_yahoo_daily_date ON dt_yahoo_daily(date_id);
CREATE INDEX idx_yahoo_daily_date2 ON dt_yahoo_daily(date_id DESC);

COMMENT ON TABLE  dt_yahoo_daily IS 'Daily data from Yahoo! Finance';
COMMENT ON COLUMN dt_yahoo_daily.id IS		'Primary Key';
COMMENT ON COLUMN dt_yahoo_daily.date_id IS	'Date (for use with Date Dimension)';
COMMENT ON COLUMN dt_yahoo_daily.symbol IS	'Ticker Symbol for Market Exchanges';
COMMENT ON COLUMN dt_yahoo_daily.price IS	'Closing Price';

COMMIT;

/*

*/
