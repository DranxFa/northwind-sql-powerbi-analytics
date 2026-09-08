SELECT
	e.EmployeeID,
	CONCAT(e.FirstName, ' ', e.LastName) AS Nombres,
	c.Country,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) as IngresoTotal
FROM 
	Employees e
INNER JOIN
	Orders o
		ON e.EmployeeID = o.EmployeeID
INNER JOIN
	Customers c
		ON o.CustomerID = c.CustomerID
INNER JOIN 
	[Order Details] od
		ON o.OrderID = od.OrderID
GROUP BY
	e.EmployeeID, c.Country, e.FirstName, e.LastName
ORDER BY
	EmployeeID,
	IngresoTotal desc