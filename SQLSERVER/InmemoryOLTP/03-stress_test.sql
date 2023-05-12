use AdventureWorks 
go

Demo.usp_DemoReset

select count(*) from [Sales].[SalesOrderHeader_ondisk]
select count(*) from [Sales].[SalesOrderHeader_inmem]


-- demo lecturas
select top 100 * from [Sales].[SalesOrderHeader_inmem]

select top 100 * from [Sales].[SalesOrderHeader_ondisk]


select top 1000 * from [Sales].[SalesOrderHeader_inmem]

select top 1000 * from [Sales].[SalesOrderHeader_ondisk]

select * from [Sales].[SalesOrderHeader_inmem]

select * from [Sales].[SalesOrderHeader_ondisk]


/* stress lecturas

ostress.exe -n100 -r5000 -S. -E -dAdventureWorks -q -Q"select top 100 * from [Sales].[SalesOrderHeader_ondisk]"

ostress.exe -n100 -r5000 -S. -E -dAdventureWorks -q -Q"select top 100 * from [Sales].[SalesOrderHeader_inmem]"

*/

-- usar el activity monitor :-)

-- ostress on disk
/*
ostress.exe -n100 -r100 -S. -E -dAdventureWorks -q -Q"DECLARE @i int = 0, @od Sales.SalesOrderDetailType_ondisk, @SalesOrderID int, @DueDate datetime2 = getdate()+1, @CustomerID int = rand() * 8000, @BillToAddressID int = rand() * 10000, @ShipToAddressID int = rand() * 10000, @ShipMethodID int = (rand() * 5) + 1; INSERT INTO @od SELECT OrderQty, ProductID, SpecialOfferID FROM Demo.DemoSalesOrderDetailSeed WHERE OrderID= cast((rand()*106) + 1 as int); while (@i < 20) begin; EXEC Sales.usp_InsertSalesOrder_ondisk @SalesOrderID OUTPUT, @DueDate, @CustomerID, @BillToAddressID, @ShipToAddressID, @ShipMethodID, @od; set @i += 1 end"

*/

-- ostress on memory
/*
ostress.exe -n100 -r100 -S. -E -dAdventureWorks -q -Q"DECLARE @i int = 0, @od Sales.SalesOrderDetailType_inmem, @SalesOrderID int, @DueDate datetime2 = getdate()+1, @CustomerID int = rand() * 8000, @BillToAddressID int = rand() * 10000, @ShipToAddressID int = rand() * 10000, @ShipMethodID int = (rand() * 5) + 1; INSERT INTO @od SELECT OrderQty, ProductID, SpecialOfferID FROM Demo.DemoSalesOrderDetailSeed WHERE OrderID= cast((rand()*106) + 1 as int); while (@i < 20) begin; EXEC Sales.usp_InsertSalesOrder_inmem @SalesOrderID OUTPUT, @DueDate, @CustomerID, @BillToAddressID, @ShipToAddressID, @ShipMethodID, @od; set @i += 1 end"

*/


select count(1) from [Sales].[SalesOrderHeader_inmem]
select count(1) from [Sales].[SalesOrderHeader_ondisk]

