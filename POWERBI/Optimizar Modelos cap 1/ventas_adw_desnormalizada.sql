--- ventas desnormalizado
use AdventureWorksDW2019 
go

SELECT dbo.ventas.*, 
dbo.DimCustomer.CustomerAlternateKey as customer_CustomerAlternateKey , 
dbo.DimCustomer.Title as customer_Title , 
dbo.DimCustomer.FirstName as customer_FirstName , 
dbo.DimCustomer.MiddleName as customer_MiddleName , 
dbo.DimCustomer.LastName as customer_LastName , 
dbo.DimCustomer.BirthDate as customer_BirthDate, 
dbo.DimCustomer.MaritalStatus as customer_MaritalStatus , 
dbo.DimCustomer.Gender as customer_Gender, 
dbo.DimCustomer.EmailAddress as customer_EmailAddress, 
dbo.DimCustomer.SpanishEducation as customer_SpanishEducation, 
dbo.DimCustomer.SpanishOccupation as customer_SpanishOccupation, 
dbo.DimCustomer.NumberCarsOwned as customer_NumberCarsOwned, 
dbo.DimCustomer.HouseOwnerFlag as customer_HouseOwnerFlag , 
dbo.DimCustomer.TotalChildren as customer_TotalChildren, 
dbo.DimCustomer.NumberChildrenAtHome as customer_NumberChildrenAtHome, 
dbo.DimGeography.City as Geography_city, 
dbo.DimGeography.StateProvinceName as Geography_StateProvinceName, 
dbo.DimGeography.SpanishCountryRegionName as Geography_SpanishCountryRegionName, 
dbo.DimGeography.PostalCode as Geography_PostalCode, 
dbo.DimProduct.ProductAlternateKey as Product_ProductAlternateKey, 
dbo.DimProduct.SpanishProductName as Product_SpanishProductName , 
dbo.DimProduct.Color as Product_Color, 
dbo.DimProduct.Size as Product_Size, 
dbo.DimProduct.Weight as Product_Weight, 
dbo.DimProduct.EnglishDescription as Product_EnglishDescription
FROM     dbo.ventas INNER JOIN
                  dbo.DimCustomer ON dbo.ventas.CustomerKey = dbo.DimCustomer.CustomerKey INNER JOIN
                  dbo.DimGeography ON dbo.DimCustomer.GeographyKey = dbo.DimGeography.GeographyKey INNER JOIN
                  dbo.DimProduct ON dbo.ventas.ProductKey = dbo.DimProduct.ProductKey