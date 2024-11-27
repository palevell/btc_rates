-- dt_prices.sql - Thursday, November 14, 2024

CREATE TABLE IF NOT EXISTS dt_prices (
	id		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	date_id		TEXT NOT NULL,
	date_time	DATETIME NOT NULL,
	cad		DOUBLE NOT NULL,
	usd		DOUBLE NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_prices_date_date_time ON dt_prices(date_time);
CREATE INDEX IF NOT EXISTS idx_prices_date_date_time2 ON dt_prices(date_time DESC);
CREATE INDEX IF NOT EXISTS idx_prices_date_id ON dt_prices(date_id);
