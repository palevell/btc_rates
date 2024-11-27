-- prices.sql - Saturday, November 16, 2024
/* View: prices  */

CREATE VIEW prices AS
SELECT	dp.date_time, dp.cad, dp.usd, dd.*
FROM	dt_prices dp INNER JOIN
	dim_date dd ON
		dp.date_id = dd.date_id;
