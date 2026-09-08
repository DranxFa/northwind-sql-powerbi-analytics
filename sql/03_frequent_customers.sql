SELECT o.CustomerID, COUNT(OrderID) as Pedidos
FROM Orders o 
GROUP BY o.CustomerID
HAVING COUNT(OrderID) > 10
ORDER BY Pedidos desc