SELECT TOP 10
	p.ProductName,
	c.CategoryName,
	SUM(o.UnitPrice * o.Quantity * (1 - o.Discount)) as IngresoTotal
FROM 
	[Order Details] o
INNER JOIN 
	Products p ON o.ProductID = p.ProductID
INNER JOIN
	Categories c ON p.CategoryID = c.CategoryID
GROUP BY
	p.ProductName, c.CategoryName
ORDER BY IngresoTotal desc