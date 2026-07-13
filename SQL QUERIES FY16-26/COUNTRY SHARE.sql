with cte as(select COUNTRY, round(sum(trade_value_usd)/1000000000,0) as trade from fy16_26 group by 1)
select COUNTRY, 
		trade as 'Export in Billion USD', 
		round(trade*100/ sum(trade) over (),2) as 'Share %' 
from cte 
order by 3 desc