USE mydb;
SELECT Clients.client_id, Clients.name, COUNT(Orders.order_id) AS order_count
FROM Clients
JOIN Orders ON Clients.client_id = Orders.client_id
GROUP BY Clients.client_id, Clients.name
ORDER BY order_count DESC
LIMIT 5;