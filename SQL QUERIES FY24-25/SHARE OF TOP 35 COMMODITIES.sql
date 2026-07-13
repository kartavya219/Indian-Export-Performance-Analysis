with top20 as(SELECT
    RANK() OVER (ORDER BY SUM(Trade_Value_USD) DESC) AS `Rank`,
    PC_Code,
    Commodity,
    ROUND(SUM(Trade_Value_USD) / 1000000, 0) AS Trade
FROM fy25
GROUP BY
    PC_Code,
    Commodity
ORDER BY
    SUM(Trade_Value_USD) DESC
    limit 35),

total as(SELECT 
    SUM(Trade_Value_USD) / 1000000 AS Trade
FROM
    fy25)
    
    
SELECT  SUM(tt.trade) OVER () * 100/t.trade AS 'TOTAL SHARE %'  from  top20 tt join total t limit 1