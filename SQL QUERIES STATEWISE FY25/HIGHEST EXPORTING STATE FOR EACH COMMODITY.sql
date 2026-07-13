WITH cte AS
(
SELECT
    Commodity,
    State,
    SUM(Trade_Value_USD) exports,
    ROW_NUMBER() OVER(
        PARTITION BY Commodity
        ORDER BY SUM(Trade_Value_USD) DESC
    ) rn
FROM state_exports_25
GROUP BY Commodity, State
)

SELECT
    Commodity,
    State,
    ROUND(exports/1000000,2) AS `Million USD`
FROM cte
WHERE rn=1
ORDER BY 2 DESC