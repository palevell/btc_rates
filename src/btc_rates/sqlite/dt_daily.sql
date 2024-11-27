-- dt_daily.sql - Friday, November 15, 2024

CREATE TABLE IF NOT EXISTS dt_daily (
	id		INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	date_id		TEXT NOT NULL,

	cad_open	DOUBLE NOT NULL,
	cad_close	DOUBLE NOT NULL,
	cad_hi		DOUBLE NOT NULL,
	cad_lo		DOUBLE NOT NULL,
	cad_chg_amt	DOUBLE NOT NULL,
	cad_chg_pct	DOUBLE NOT NULL,

	usd_open	DOUBLE NOT NULL,
	usd_close	DOUBLE NOT NULL,
	usd_hi		DOUBLE NOT NULL,
	usd_lo		DOUBLE NOT NULL,
	usd_chg_amt	DOUBLE NOT NULL,
	usd_chg_pct	DOUBLE NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_daily_date_id ON dt_daily(date_id);
CREATE INDEX IF NOT EXISTS idx_daily_date_id2 ON dt_daily(date_id DESC);
