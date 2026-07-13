with cte as(select continent, 
					commodity, 
                    sum(trade_value_usd) as trade 
			from fy16_26 
            group by 1,2),

xte as (select continent, 
				commodity, 
                trade/1000000000 as trade_B, 
                row_number() over (partition by continent order by trade desc) as rn 
		from cte)
SELECT 
    Continent, Commodity, trade_B AS 'Export in Billion USD'
FROM
    xte
WHERE
    rn = 1
ORDER BY 3 DESC