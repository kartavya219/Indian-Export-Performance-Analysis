with top10 as(SELECT
    RANK() OVER (ORDER BY SUM(Trade_Value_USD) DESC) AS `Rank`,
    country,
    SUM(Trade_Value_USD) AS Trade
FROM fy16_26
GROUP BY
   country
ORDER BY
    SUM(Trade_Value_USD) DESC
    limit 10),

total as(SELECT 
    SUM(Trade_Value_USD)  AS Trade
FROM
    fy16_26)
    
SELECT  SUM(tt.trade) OVER () * 100/t.trade AS 'TOTAL SHARE %'  from  top10 tt join total t limit 1