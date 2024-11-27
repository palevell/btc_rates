CREATE VIEW daily_prices AS 
SELECT  date_id, COUNT(*) AS quotes,
	MIN(cad) AS cad_lo, MAX(cad) AS cad_hi,
	MIN(usd) AS usd_lo, MAX(usd) AS usd_hi
FROM    dt_prices
GROUP BY date_id
ORDER BY date_id;
