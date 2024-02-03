USE mydb;
SELECT
    cs.name AS cleaning_service_name,
    COUNT(o.order_id) AS order_count
FROM
    Cleaning_Service cs
JOIN
    Orders o ON cs.order_id = o.order_id
GROUP BY
    cs.name
ORDER BY
    order_count DESC
LIMIT 5;