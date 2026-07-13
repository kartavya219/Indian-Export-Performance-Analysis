with cte as(SELECT 
    Financial_Year,
    ROUND(SUM(Trade_Value_USD) / 1000000000, 0) AS Trade_in_Billion_USD,
    lag( ROUND(SUM(Trade_Value_USD) / 1000000000, 0)) over (order by financial_year) as prev_trade
FROM
    fy16_26
group by 1
ORDER BY 1)

SELECT 
    Financial_Year,
    Trade_in_Billion_USD,
    (Trade_in_Billion_USD - prev_trade) * 100 / prev_trade AS 'Year-on-Year Growth %'
FROM
    cte