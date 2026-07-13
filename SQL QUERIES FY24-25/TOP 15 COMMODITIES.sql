SELECT
    RANK() OVER (ORDER BY SUM(Trade_Value_USD) DESC) AS `Rank`,
    PC_Code,
    Commodity,
    ROUND(SUM(Trade_Value_USD) / 1000000, 0) AS `Million USD`
FROM fy25
GROUP BY
    PC_Code,
    Commodity
ORDER BY
    SUM(Trade_Value_USD) DESC
LIMIT 15;