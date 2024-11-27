-- daily.sql - Saturday, November 16, 2024
/**/

DROP VIEW daily;

CREATE VIEW daily AS
SELECT	d.*, dd.*
FROM	dt_daily d INNER JOIN
	dim_date dd ON
		d.date_id = dd.date_id;
