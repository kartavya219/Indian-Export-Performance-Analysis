WITH country_year AS (
    SELECT
        Country,
        Financial_Year,
        SUM(Trade_Value_USD) AS exports
    FROM fy16_26
    GROUP BY Country, Financial_Year
),

country_values AS (
    SELECT
        Country,
        MAX(CASE WHEN Financial_Year = (SELECT MIN(Financial_Year) FROM fy16_26)
            THEN exports END) AS Beginning_Value,

        MAX(CASE WHEN Financial_Year = (SELECT MAX(Financial_Year) FROM fy16_26)
            THEN exports END) AS Ending_Value
    FROM country_year
    GROUP BY Country
)

SELECT 
    Country,
    ROUND(Beginning_Value / 1000000, 2) AS `Beginning Export (Million USD)`,
    ROUND(Ending_Value / 1000000, 2) AS `Ending Export (Million USD)`,
    ROUND((POWER(Ending_Value / Beginning_Value, 1.0 / ((SELECT  MAX(Financial_Year) FROM fy16_26) - (SELECT MIN(Financial_Year) FROM fy16_26))) - 1) * 100, 2) AS `CAGR (%)`
FROM
    country_values
WHERE
    Beginning_Value IS NOT NULL
        AND Ending_Value IS NOT NULL
        AND Beginning_Value > 0
ORDER BY 3 DESC;