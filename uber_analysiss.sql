create database uber_projects;

use uber_projects;

select count(*) AS total,
sum(pickup_datetime = '01-01-9999 00:00') AS bad_date,
SUM(status = 'Completed' AND fare_amount = 0) AS zero_fare,
SUM(status = 'Completed' AND rating = '')  AS null_rating
 from uber_rides_india;

ALTER TABLE uber_rides_india ADD COLUMN pickup_ts DATETIME AFTER pickup_datetime;

UPDATE uber_rides_india
SET pickup_ts = STR_TO_DATE(pickup_datetime, '%d-%m-%Y %H:%i')
WHERE pickup_datetime <> '01-01-9999 00:00';   

SET SQL_SAFE_UPDATES =0;

   
DELETE FROM uber_rides_india
WHERE pickup_datetime = '01-01-9999 00:00'      
OR pickup_ts IS NULL;                        


   
DELETE FROM uber_rides_india
WHERE status = 'Completed' AND fare_amount = 0;

   
   
UPDATE uber_rides_india
SET rating = (
        SELECT ROUND(AVG(rating))
        FROM (SELECT rating FROM uber_rides_india
              WHERE status = 'Completed' AND rating IS NOT NULL) AS t
     )
WHERE status = 'Completed' AND rating = '';

select count(*) from uber_rides_india;




/* =====================================================================
   SECTION 3 — ANALYSIS  (5 problems, easy → medium)
   ===================================================================== */


SELECT
    COUNT(*)                                                  AS total_rides,
    SUM(status = 'Completed')                                 AS completed_rides,
    SUM(status = 'Cancelled')                                 AS cancelled_rides,
    ROUND(SUM(CASE WHEN status='Completed' THEN fare_amount END), 2) AS total_revenue,
    ROUND(AVG(CASE WHEN status='Completed' THEN fare_amount END), 2) AS avg_fare,
    ROUND(AVG(rating ), 2) AS avg_rating
FROM uber_rides_india;


SELECT
    city,
    COUNT(*)                       AS completed_rides,
    ROUND(SUM(fare_amount), 2)     AS total_revenue,
    ROUND(AVG(fare_amount), 2)     AS avg_fare
FROM uber_rides_india
WHERE status = 'Completed'
GROUP BY city
ORDER BY total_revenue DESC;

SELECT
    ride_type,
    COUNT(*)                                        AS rides,
    ROUND(SUM(fare_amount), 2)                      AS total_revenue,
    ROUND(AVG(distance_km), 2)                      AS avg_distance_km,
    ROUND(SUM(fare_amount) / SUM(distance_km), 2)   AS revenue_per_km
FROM uber_rides_india
WHERE status = 'Completed'
GROUP BY ride_type
ORDER BY total_revenue DESC;

SELECT
    hour,
    COUNT(*)                                                       AS rides,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2)             AS pct_of_rides
FROM uber_rides_india
GROUP BY hour
ORDER BY rides DESC;

SELECT
    city,
    COUNT(*)                                                         AS total_rides,
    SUM(status = 'Cancelled')                                        AS cancelled_rides,
    ROUND(100.0 * SUM(status = 'Cancelled') / COUNT(*), 2)           AS cancellation_rate_pct
FROM uber_rides_india
GROUP BY city
ORDER BY cancellation_rate_pct DESC;
