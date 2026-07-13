with last as (SELECT 
    MAX(financial_year) year
FROM
    fy16_26),
    
first as (SELECT 
    MIN(financial_year) year
FROM
    fy16_26),
    
number as (SELECT 
    MAX(financial_year) - MIN(financial_year) AS n
FROM
    fy16_26),
    
end as (SELECT 
    SUM(trade_value_usd) AS end
FROM
    fy16_26
        JOIN
    last l ON Financial_Year = l.year),
    
start as (SELECT 
    SUM(trade_value_usd) AS start
FROM
    fy16_26
        JOIN
    first f ON Financial_Year = f.year)
    
SELECT 
    ROUND((POWER((e.end / s.start), 1 / n.n) - 1) * 100,
            2) AS 'CAGR%'
FROM
    end e
        JOIN
    start s
        JOIN
    number n