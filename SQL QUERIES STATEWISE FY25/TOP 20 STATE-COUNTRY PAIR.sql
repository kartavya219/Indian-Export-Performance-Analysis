SELECT
    State,
    Country,
    ROUND(SUM(Trade_Value_USD)/1000000,2) AS `Million USD`
FROM state_exports_25
GROUP BY State, Country
ORDER BY SUM(Trade_Value_USD) DESC
LIMIT 20;