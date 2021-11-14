
SELECT
   c.CustID
   ,c.FirstName
   ,c.LastName
FROM #Customer c
WHERE c.LastName LIKE 'S%'
ORDER BY c.FirstName DESC, c.LastName DESC;

SELECT
   c.CustID
   ,c.FirstName
   ,c.LastName
   ,COALESCE(SUM(ol.Cost), 0.00) AS SixMonthTotal
FROM #Customer c
LEFT JOIN #Order o on o.CustomerID = c.CustID
   AND o.OrderDate >= DATEADD(month, -6, GETDATE())
LEFT JOIN #OrderLine ol on ol.OrdID = o.OrderID
GROUP BY c.CustID, c.FirstName ,c.LastName;

SELECT
   c.CustID
   ,c.FirstName
   ,c.LastName
   ,COALESCE(SUM(ol.Cost), 0.00) AS SixMonthTotal
FROM #Customer c
JOIN #Order o on o.CustomerID = c.CustID
JOIN #OrderLine ol on ol.OrdID = o.OrderID
WHERE o.OrderDate >= DATEADD(month, -6, GETDATE())
GROUP BY c.CustID, c.FirstName ,c.LastName
HAVING SUM(ol.Cost) > 100
   AND SUM(ol.Cost) < 500;