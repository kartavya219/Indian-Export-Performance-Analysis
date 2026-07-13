WITH CTE AS(SELECT
    State,
    Commodity,
    ROUND(SUM(Trade_Value_USD)/1000000,2) AS Export_Value,
    ROUND(
        SUM(Trade_Value_USD) /
        SUM(SUM(Trade_Value_USD)) OVER(PARTITION BY State) * 100,
        2
        
    ) AS Commodity_Share,
    dense_rank() OVER (PARTITION BY STATE ORDER BY SUM(Trade_Value_USD) DESC) AS RN
FROM state_exports_25
GROUP BY State, Commodity
ORDER BY 1 ASC , 3 DESC)
SELECT STATE, COMMODITY, EXPORT_VALUE, COMMODITY_SHARE FROM CTE WHERE RN = 1