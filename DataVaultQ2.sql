USE mydb;
SELECT 
    cs.cleaning_type, ps.amount as price
FROM
    CleaningSatellite cs
JOIN
    OrderCleaningLink ocl ON cs.cleaning_id = ocl.cleaning_id
JOIN
    OrderHub oh ON ocl.order_id = oh.order_id
JOIN
    OrderPaymentLink opl ON oh.order_id = opl.order_id
JOIN
    PaymentSatellite ps ON opl.payment_id = ps.payment_id
ORDER BY
	ps.amount DESC
LIMIT 5;