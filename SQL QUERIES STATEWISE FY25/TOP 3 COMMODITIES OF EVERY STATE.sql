WITH cte AS
(
SELECT
    State,
    Commodity,
    SUM(Trade_Value_USD) exports,
    RANK() OVER(
        PARTITION BY State
        ORDER BY SUM(Trade_Value_USD) DESC
    ) rn
FROM state_exports_25
GROUP BY State, Commodity
)

SELECT
    State,
    Commodity,
    ROUND(exports/1000000,2) AS `Million USD`
FROM cte
WHERE rn<=3
ORDER BY 1,3 DESC