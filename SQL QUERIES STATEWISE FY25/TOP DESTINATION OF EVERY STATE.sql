WITH cte AS
(
SELECT
    State,
    Country,
    SUM(Trade_Value_USD) exports,
    ROW_NUMBER() OVER(
        PARTITION BY State
        ORDER BY SUM(Trade_Value_USD) DESC
    ) rn
FROM state_exports_25
GROUP BY State, Country
)

SELECT
    State,
    Country,
    ROUND(exports/1000000,2) AS `Million USD`
FROM cte
WHERE rn=1
ORDER BY 3 DESC