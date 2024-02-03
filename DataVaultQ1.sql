USE mydb;
SELECT
    css.name AS cleaning_service_name,
    COUNT(os.order_id) AS order_count
FROM
    CleaningServiceSatellite css
JOIN
    CleaningServiceHub cs ON css.service_id = cs.service_id
LEFT JOIN
    OrderCleaningServiceLink ocsl ON cs.service_id = ocsl.service_id
LEFT JOIN
    OrderSatellite os ON ocsl.order_id = os.order_id
GROUP BY
    css.name
ORDER BY
    order_count DESC
LIMIT 5