/* row_number() rank() y denseRank()
   Maximiliano Accotto
   https://blogs.triggerdb.com
*/

ROW_NUMBER ( )   
    OVER ( [ PARTITION BY value_expression , ... [ n ] ] order_by_clause )  

--ejemplo1
SELECT 
  ROW_NUMBER() OVER(ORDER BY name ASC) AS row#,
  name, recovery_model_desc,compatibility_level 
FROM sys.databases 

-- usando partition

SELECT 
  ROW_NUMBER() OVER(PARTITION BY compatibility_level  ORDER BY name ASC) 
    AS Row#,
  name, recovery_model_desc,compatibility_level 
FROM sys.databases 

-- Uses AdventureWorks  

use AdventureWorksDW2019 
go
  
SELECT ROW_NUMBER() OVER(ORDER BY SUM(SalesAmountQuota) DESC) 
    AS RowNumber,  
    FirstName, LastName,   
    CONVERT(varchar(13), SUM(SalesAmountQuota),1) AS SalesQuota   
FROM dbo.DimEmployee AS e  
INNER JOIN dbo.FactSalesQuota AS sq  
    ON e.EmployeeKey = sq.EmployeeKey  
WHERE e.SalesPersonFlag = 1  
GROUP BY LastName, FirstName;

-------- ranking
use AdventureWorks2019 
go

SELECT i.ProductID, 
       p.Name, 
	   i.LocationID, 
	   i.Quantity,
	   RANK() OVER (PARTITION BY i.LocationID ORDER BY i.Quantity DESC) AS Rank  
	  ,DENSE_RANK() OVER (PARTITION BY i.LocationID ORDER BY i.Quantity DESC) AS Dense_Rank 
FROM Production.ProductInventory AS i   
INNER JOIN Production.Product AS p   
    ON i.ProductID = p.ProductID  
WHERE i.LocationID BETWEEN 3 AND 4  
ORDER BY i.LocationID;  

