SELECT
    State,
    ROUND(SUM(Trade_Value_USD)/1000000,2) AS `Million USD`,
    ROUND(
        SUM(Trade_Value_USD)/
        (SELECT SUM(Trade_Value_USD) FROM state_exports_25)*100,
        2
    ) AS Contribution_Percentage
FROM state_exports_25
GROUP BY State
ORDER BY Contribution_Percentage DESC
limit 20;