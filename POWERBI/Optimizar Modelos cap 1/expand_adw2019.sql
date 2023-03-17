use AdventureWorksDW2019 
go

drop table if exists dbo.ventas 

CREATE TABLE dbo.ventas
	(
   	SalesKey bigint NOT NULL IDENTITY (1, 1) primary key,
	ProductKey int NOT NULL,
	OrderDateKey int NOT NULL,
	DueDateKey int NOT NULL,
	ShipDateKey int NOT NULL,
	CustomerKey int NOT NULL,
	PromotionKey int NOT NULL,
	CurrencyKey int NOT NULL,
	SalesTerritoryKey int NOT NULL,
	SalesOrderNumber nvarchar(20) NOT NULL,
	SalesOrderLineNumber tinyint NOT NULL,
	RevisionNumber tinyint NOT NULL,
	OrderQuantity smallint NOT NULL,
	UnitPrice money NOT NULL,
	ExtendedAmount money NOT NULL,
	UnitPriceDiscountPct float(53) NOT NULL,
	DiscountAmount float(53) NOT NULL,
	ProductStandardCost money NOT NULL,
	TotalProductCost money NOT NULL,
	SalesAmount money NOT NULL,
	TaxAmt money NOT NULL,
	Freight money NOT NULL,
	CarrierTrackingNumber nvarchar(25) NULL,
	CustomerPONumber nvarchar(25) NULL,
	OrderDate datetime NULL,
	DueDate datetime NULL,
	ShipDate datetime NULL,
	)  ON [PRIMARY]
GO


INSERT INTO [dbo].[ventas]
           ([ProductKey]
           ,[OrderDateKey]
           ,[DueDateKey]
           ,[ShipDateKey]
           ,[CustomerKey]
           ,[PromotionKey]
           ,[CurrencyKey]
           ,[SalesTerritoryKey]
           ,[SalesOrderNumber]
           ,[SalesOrderLineNumber]
           ,[RevisionNumber]
           ,[OrderQuantity]
           ,[UnitPrice]
           ,[ExtendedAmount]
           ,[UnitPriceDiscountPct]
           ,[DiscountAmount]
           ,[ProductStandardCost]
           ,[TotalProductCost]
           ,[SalesAmount]
           ,[TaxAmt]
           ,[Freight]
           ,[CarrierTrackingNumber]
           ,[CustomerPONumber]
           ,[OrderDate]
           ,[DueDate]
           ,[ShipDate])
select
           [ProductKey]
           ,[OrderDateKey]
           ,[DueDateKey]
           ,[ShipDateKey]
           ,[CustomerKey]
           ,[PromotionKey]
           ,[CurrencyKey]
           ,[SalesTerritoryKey]
           ,[SalesOrderNumber]
           ,[SalesOrderLineNumber]
           ,[RevisionNumber]
           ,[OrderQuantity]
           ,[UnitPrice]
           ,[ExtendedAmount]
           ,[UnitPriceDiscountPct]
           ,[DiscountAmount]
           ,[ProductStandardCost]
           ,[TotalProductCost]
           ,[SalesAmount]
           ,[TaxAmt]
           ,[Freight]
           ,[CarrierTrackingNumber]
           ,[CustomerPONumber]
           ,[OrderDate]
           ,[DueDate]
           ,[ShipDate]
FROM dbo.FactInternetSales 
go 500

--select count(1) from dbo.ventas


