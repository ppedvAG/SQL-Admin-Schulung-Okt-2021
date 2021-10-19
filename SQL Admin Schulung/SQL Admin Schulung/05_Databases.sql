/*
create database testdb-- viele Fehlern

Wie gro� ist die DB eigtl?
16 MB (8+8MB)

Wachstumsrate?
pro Log und Datendatei: 64MB

bis SQL 2014
5MB +2 MB  --> 7 MB
Wachstum: Daten +1 MB   Logfile + 10%

--echt krankes Zeug!!


Eigtl w�ren andere Werte besser:

andere Startgr��e geben f�r Datendatei:
	-wie lange soll die DB bzw der Server auf dem Rechner laufen?
	-Logfile: ca 25% der Daten.. Das Logfile sollte nie �ber 70% voll werden
								und darf nie wachsen
--KOntrolle zb �ber Bercihte der DB via Standardbericht: Datentr�gerverwendung


Wachstumsrate: Logfile gute Idee: 1000MB
				Datendatei: + 1000MB soll kurz dauern und selten



*/

create database testdb

USE [master]
GO
ALTER DATABASE [testdb] MODIFY FILE 
	( NAME = N'testdb', SIZE = 102400KB , FILEGROWTH = 1024000KB )
GO
ALTER DATABASE [testdb] MODIFY FILE 
	( NAME = N'testdb_log', SIZE = 25600KB , FILEGROWTH = 1024000KB )
GO
CREATE DATABASE [testdb2014]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'testdb2014', FILENAME = N'D:\_SQLDB\testdb2014.mdf' , 
SIZE = 1024KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'testdb2014_log', FILENAME = N'D:\_SQLDB\testdb2014_log.ldf' , 
SIZE = 1024KB , FILEGROWTH = 10%)
GO


--TEST
use testdb;
GO

create table t1 (id int identity, sp1 char(4100));
Go

insert into t1
select 'XY'
GO 20000

--Wie gro�?--20000*4kb--> 80MB -----26 Sekunden

use testdb2014;
GO

create table t1 (id int identity, sp1 char(4100));
Go

insert into t1
select 'XY'
GO 20000 --- 1 Sekunde langsamer

--seltsam... 80MB Daten sind 160MB

--testdb2014 hatte zig vergr��erungen.. ca 3 Sek mehr
--testdb nur ein Vergr��erung...