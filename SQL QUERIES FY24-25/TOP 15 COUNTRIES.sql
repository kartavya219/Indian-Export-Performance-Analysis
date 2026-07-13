SELECT
    RANK() OVER (ORDER BY SUM(Trade_Value_USD) DESC) AS `Rank`,
    Country,
    ROUND(SUM(Trade_Value_USD) / 1000000, 0) AS `Million USD`
FROM fy25
GROUP BY
    Country
ORDER BY
    SUM(Trade_Value_USD) DESC
LIMIT 15;