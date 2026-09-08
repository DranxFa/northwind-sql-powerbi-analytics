WITH suma_ingresos_productos AS 
	(
	SELECT
		p.ProductName,
		c.CategoryName,
		ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) as IngresoTotal
	FROM
		[Order Details] od
	INNER JOIN 
		Products p 
			ON od.ProductID = p.ProductID
	INNER JOIN
		Categories c
			ON p.CategoryID = c.CategoryID
	GROUP BY
		p.ProductName, c.CategoryName
	)

SELECT 
	ProductName,
	CategoryName,
	IngresoTotal,
	RANK() OVER (PARTITION BY CategoryName ORDER BY IngresoTotal desc) as RankingCategoria
FROM
	suma_ingresos_productos;