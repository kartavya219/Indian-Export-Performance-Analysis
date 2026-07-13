SELECT
    State,
    COUNT(DISTINCT Country) AS Countries_Exported_To
FROM state_exports_25
GROUP BY State
ORDER BY Countries_Exported_To DESC;