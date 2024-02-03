USE mydb;
SELECT
	ch.client_id,
    cs.name,
    COUNT(oh.order_id) AS total_orders
FROM
    ClientHub ch
JOIN
    ClientOrderLink col ON ch.client_id = col.client_id
JOIN 
	ClientSatellite cs ON ch.client_id = cs.client_id
JOIN
    OrderHub oh ON col.order_id = oh.order_id
GROUP BY
    ch.client_id, cs.name
ORDER BY 
	total_orders DESC
LIMIT 5
