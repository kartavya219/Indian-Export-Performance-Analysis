SELECT
Commodity,
COUNT(DISTINCT Country) Countries
FROM fy16_26
GROUP BY Commodity
ORDER BY Countries DESC;