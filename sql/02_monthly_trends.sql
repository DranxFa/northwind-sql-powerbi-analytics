SELECT
	FORMAT(o.OrderDate, 'yyyy-MM') as Mes,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) as IngresoTotal
FROM 
	Orders o
INNER JOIN 
	[Order Details] od ON o.OrderID = od.OrderID
GROUP BY
	FORMAT(o.OrderDate, 'yyyy-MM')
ORDER BY
	Mes