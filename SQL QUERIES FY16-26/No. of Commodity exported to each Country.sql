SELECT
Country,
COUNT(DISTINCT Commodity) Commodities
FROM fy16_26
GROUP BY Country
ORDER BY Commodities DESC;