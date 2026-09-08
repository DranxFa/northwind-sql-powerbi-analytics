WITH suma_ingreso_pedidos AS 
	(
	SELECT 
		s.SupplierID,
		s.CompanyName,
		ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) as IngresoTotal
	FROM 
		[Order Details] od
	INNER JOIN
		Products p
			ON p.ProductID = od.ProductID
	INNER JOIN
		Suppliers s
			ON p.SupplierID = s.SupplierID
	GROUP BY 
		s.SupplierID, s.CompanyName
	)

SELECT
	SupplierID,
	CompanyName,
	IngresoTotal,
	IngresoTotal / SUM(IngresoTotal) OVER() * 100 AS Porcentaje 
FROM 
	suma_ingreso_pedidos
ORDER BY
	IngresoTotal desc;