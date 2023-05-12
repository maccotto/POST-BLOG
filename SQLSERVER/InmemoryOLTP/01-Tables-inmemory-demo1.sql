--- IN MEMORY DEMO
USE MASTER
GO

DROP DATABASE IF EXISTS imoltp

CREATE DATABASE imoltp
ON PRIMARY (name = [imoltp_data], filename = 'f:\sql\imoltp_mod1.mdf', 
            size=500MB)
LOG ON (name = [imoltp_log], filename='f:\sql\imoltp_log.ldf', 
        size=500MB)
GO
 
ALTER DATABASE imoltp 
ADD FILEGROUP [imoltp_mod] CONTAINS MEMORY_OPTIMIZED_DATA
ALTER DATABASE imoltp 
ADD FILE (name = [imoltp_dir], 
          filename= 'f:\sql\imoltp_dir') 
TO FILEGROUP imoltp_mod;
GO

---- OBJETOS

USE imoltp;
GO

IF EXISTS (SELECT NAME FROM sys.objects  WHERE NAME = 'xx')
   DROP PROCEDURE xx
GO

IF EXISTS (SELECT NAME FROM sys.objects WHERE NAME = 'sql')
   DROP TABLE sql
GO

IF EXISTS (SELECT NAME FROM sys.objects WHERE NAME = 'hash')
   DROP TABLE hash
GO

IF EXISTS (SELECT NAME FROM sys.objects  WHERE NAME = 'hash1')
   DROP TABLE hash1
GO

--- CREAMOS UNA TABLA EN MEMORIA
-- MIRAR EL DIRECTORIO d:\tmp\imoltp_dir

-- With index specification, you also need to specify the BUCKET COUNT.  
-- The recommended value for this should be two times the expected 
-- number of unique values of that column. 


CREATE TABLE [dbo].[T_MEM1] (
  c1 INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT=1000000),
  c2 NCHAR(48) NOT NULL
) WITH (MEMORY_OPTIMIZED=ON, DURABILITY = SCHEMA_AND_DATA);
GO

--- INSERTAMOS REGISTROS
SELECT TOP 100000
        IDENTITY( INT,1,1 ) AS n
INTO    #Nums
FROM    Master.dbo.SysColumns sc1
       ,Master.dbo.SysColumns sc2 ;

INSERT INTO T_MEM1 (C1,C2) 
SELECT n, 'REGISTRO' + CONVERT(VARCHAR(5),n)
FROM #Nums

--- consultamos la tabla HASH
select * from t_mem1

-- uso en memoria

SELECT object_name(object_id) AS Name
     , *
   FROM sys.dm_db_xtp_table_memory_stats

--- creamos tabla no persistente
CREATE TABLE [dbo].[T_MEM2] (
  c1 INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT=1000000),
  c2 NCHAR(48) NOT NULL
) WITH (MEMORY_OPTIMIZED=ON, DURABILITY = SCHEMA_ONLY);
GO

--- INSERTAMOS REGISTROS
SELECT TOP 10
        IDENTITY( INT,1,1 ) AS n
INTO    #Nums2
FROM    Master.dbo.SysColumns sc1
       ,Master.dbo.SysColumns sc2 ;

INSERT INTO T_MEM2 (C1,C2) 
SELECT n, 'REGISTRO' + CONVERT(VARCHAR(5),n)
FROM #Nums2 


-- uso en memoria

SELECT object_name(object_id) AS Name
     , *
   FROM sys.dm_db_xtp_table_memory_stats
where object_name(object_id) in ('T_MEM2','T_MEM1')

select count(1) from dbo.T_MEM1 
select count(1) from dbo.T_MEM2 


--- QUERY PLAN

SELECT C1,C2 FROM T_MEM1 
WHERE C1=1

SELECT C2 FROM T_MEM1 
WHERE C2 = 'REGISTRO0'

--- CREAMOS TABLA CON INDICE HASH

