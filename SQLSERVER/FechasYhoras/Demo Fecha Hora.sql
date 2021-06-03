/*
  ********************************************************************
  Tipos de datos Fecha & Hora
  TriggerDB Consulting
  http://www.triggerdb.com
  Maximiliano Damian Accotto 
  ********************************************************************
*/



---------------------------------------------------------------------
-- Date & Time
---------------------------------------------------------------------

/* Tipos de datos

DATE            // 0001-01-01 through 9999-12-31             // 3 bytes
DATETIME2(p)    // 0001-01-01 through 9999-12-31             // 6 A 8 Bytes
DATETIME        // 1753-01-01 through 9999-12-31             // 8 Bytes
DATETIMEOFFSET  // 0001-01-01 through 9999-12-31             // 10 Bytes
SMALLDATETIME   // 1900-01-01 THROUGH 2079-06-06             // 4 BYTES
TIME            // 00:00:00.0000000 THROUGH 23:59:59.9999999 // 5 BYTES
*/

USE tempdb 
GO

drop table if exists FECHAS 

CREATE TABLE FECHAS (ID INT IDENTITY,
                     TDATE DATE,
					 TTIME TIME,
					 TDATETIMEOFFSET DATETIMEOFFSET,
					 TDATETIME DATETIME
					 )
GO

select GETDATE()

INSERT INTO FECHAS (TDATE,
                    TTIME,
					TDATETIMEOFFSET,
					TDATETIME)
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE())
GO 5
					    
SELECT * FROM FECHAS

SELECT MIN(TTIME) FROM FECHAS 


DROP TABLE FECHAS 

---------------------------------------------------------------------
-- Funciones 
---------------------------------------------------------------------

SELECT
  GETDATE()           AS [GETDATE],
  CURRENT_TIMESTAMP   AS [CURRENT_TIMESTAMP],
  GETUTCDATE()        AS [GETUTCDATE],
  SYSDATETIME()       AS [SYSDATETIME],
  SYSUTCDATETIME()    AS [SYSUTCDATETIME],
  SYSDATETIMEOFFSET() AS [SYSDATETIMEOFFSET];

-- DAY, MONTH, YEAR
SELECT
  DAY('20150212') AS theday,
  MONTH('20150212') AS themonth,
  YEAR('20150212') AS theyear;

-- DATENAME
SELECT DATENAME(month, '20150212');

-- SWITCHOFFSET
SELECT
  SWITCHOFFSET(SYSDATETIMEOFFSET(), '-05:00') AS [now as -05:00],
  SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00') AS [now as -08:00];

-- TODATETIMEOFFSET
SELECT TODATETIMEOFFSET('20150212 00:00:00.0000000', '-08:00');

-- DATEADD
SELECT DATEADD(MONTH, 1, '20150212');

-- DATEDIFF
SELECT DATEDIFF(MINUTE, '20150212', '20150213');

SELECT DATEDIFF(year, '20151231 23:59:59.9999999', '20160101 00:00:00.0000000');
GO

-- With DATETIMEOFFSET, DATEDIFF computes offset in UTC terms
DECLARE
  @dto1 AS DATETIMEOFFSET = '20150212 10:30:00.0000000 -08:00',
  @dto2 AS DATETIMEOFFSET = '20150213 10:30:00.0000000 -09:00';

SELECT DATEDIFF(hour, @dto1, @dto2);

-- SQL Server 2012+

-- Fromparts
SELECT
  DATEFROMPARTS(2015, 02, 12),
  DATETIME2FROMPARTS(2015, 02, 12, 13, 30, 5, 1, 7),
  DATETIMEFROMPARTS(2015, 02, 12, 13, 30, 5, 997),
  DATETIMEOFFSETFROMPARTS(2015, 02, 12, 13, 30, 5, 1, -8, 0, 7),
  SMALLDATETIMEFROMPARTS(2015, 02, 12, 13, 30),
  TIMEFROMPARTS(13, 30, 5, 1, 7);

-- EOMONTH
SELECT EOMONTH('20150415') as ultimodiames;

-- PARSE
SELECT
  PARSE('01/02/15' AS DATE USING 'es-ES') AS [Espanish],
  PARSE('01/02/15' AS DATE USING 'en-US') AS [US English];

-- FORMAT
SELECT
  FORMAT(SYSDATETIME(), 'd', 'en-US') AS [US English],
  FORMAT(SYSDATETIME(), 'd', 'es-ES') AS [Spanish];

---------------------------------------------------------------------
-- Buscar en fechas 
---------------------------------------------------------------------

USE AdventureWorks2019
GO

SELECT YEAR(ORDERDATE),MONTH(ORDERDATE)
 FROM SALES.SalesOrderHeader 
 GROUP BY YEAR(ORDERDATE),MONTH(ORDERDATE)
 ORDER BY 1,2

-- Under US English
SET LANGUAGE us_english;
--SELECT @@LANGUAGE 

SELECT COUNT(1) FROM SALES.SalesOrderHeader
WHERE OrderDate >= '30/04/2011'
AND OrderDate < '12/05/2012'

SET LANGUAGE SPANISH;
--SELECT @@LANGUAGE

SELECT COUNT(1) FROM SALES.SalesOrderHeader
WHERE OrderDate >= '01/05/2011'
AND OrderDate < '12/05/2012'

-- BEST PRACTICES ISO 
SET LANGUAGE us_english;
SELECT COUNT(1) FROM SALES.SalesOrderHeader
WHERE OrderDate >= '20110501 13:15'
AND OrderDate < '20120512 12:00'

SET LANGUAGE SPANISH;
SELECT COUNT(1) FROM SALES.SalesOrderHeader
WHERE OrderDate >= '20110501'
AND OrderDate < '20120512'

-- DESDE FECHA HASTA FECHA // DESDE EL 1-5-2011 AL 12-5-2012

USE tempdb 
GO

drop table if exists fechas

CREATE TABLE FECHAS (ID INT IDENTITY,
                     FECHA DATETIME)
GO

INSERT INTO FECHAS (FECHA)
VALUES ('20150101'),('20150101 10:39:00'),('20150201'),('20150201 15:00')

SELECT COUNT(1) FROM FECHAS
WHERE Fecha between '20150101' and '20150101'


SELECT COUNT(1) FROM FECHAS
WHERE Fecha >= '20150101' and fecha < '20150201'

--- patron WHERE campo >=@fechadesde and campo < @fechahasta + 1
