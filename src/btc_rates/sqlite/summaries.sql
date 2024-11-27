-- summaries.sql - Friday, November 15, 2024

SELECT	dp.date_id,
	max(dp.cad) cad_hi, max(dp.usd) usd_hi,
	min(dp.cad) cad_lo, min(dp.usd) usd_lo
FROM	dt_prices dp INNER JOIN
	dim_date dd ON
		dp.date_id = dd.date_id
GROUP BY dp.date_id
ORDER BY dp.date_id
LIMIT 10;
