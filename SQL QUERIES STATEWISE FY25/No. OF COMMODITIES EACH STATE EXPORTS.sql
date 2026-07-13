SELECT
    State,
    COUNT(DISTINCT Commodity) AS Commodity_Count
FROM state_exports_25
GROUP BY State
ORDER BY Commodity_Count DESC;