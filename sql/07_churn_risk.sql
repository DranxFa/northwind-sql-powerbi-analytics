WITH fecha_pedido_anterior AS (
	SELECT 
		CustomerID,
		OrderDate,
		ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY OrderDate desc) AS Ranking, 
		LAG(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) AS FechaAnterior
	FROM
		Orders
	),

gaps_con_promedio AS (
	SELECT 
		CustomerID,
		OrderDate,
		Ranking,
		DATEDIFF(day, FechaAnterior, OrderDate) AS GapActual,
		AVG(DATEDIFF(day, FechaAnterior, OrderDate)) OVER(PARTITION BY CustomerID) AS GapPromedioHistorico
	FROM 
		fecha_pedido_anterior
)

SELECT
	CustomerID,
	OrderDate,
	GapActual,
	GapPromedioHistorico
FROM 
	gaps_con_promedio
WHERE
	Ranking = 1
ORDER BY
	GapActual desc