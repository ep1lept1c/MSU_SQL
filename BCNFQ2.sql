USE mydb;
SELECT Cleaning.cleaning_type, Payment.amount as price
FROM Cleaning
JOIN Orders ON Cleaning.order_id = Orders.order_id AND Cleaning.cleaning_id = Orders.cleaning_id
JOIN Payment ON Orders.payment_id = Payment.payment_id AND Orders.order_id = Payment.order_id
ORDER BY Payment.amount DESC
LIMIT 5;