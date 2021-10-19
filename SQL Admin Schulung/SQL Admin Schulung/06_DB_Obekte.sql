/*


ad hoc Abfragen
Sicht / View
F()
Proz



*/

use northwind;
GO

--ad hoc Abfrage
select * from orders where freight < 1

--Sicht / View

create view v1
as
select * from orders where freight < 1;
GO

select * from v1 

--Sicht verhält sich wie eine Tabelle: INS UP DEL SEL hat aber keine Daten
-- Sichten haben auch Rechte
--warum eine Sicht: Vereinfachung


--Sichten Editor

--Prozeduren

create proc gpdemo1 @Fracht money
as
select * from orders where freight < @Fracht;
GO

exec gpdemo1 1

exec gpdemo1 2


--Einsatzgebiet der Prozeduren
--wie Windows Batch Datei
--man bildet of eine BI Logik
--gekapselt auf dem Server
--der Plan wird beim ersten Aufruf kompiliert und ist fix.. auch nach Neustart



--Funktion

create function fdemo1(@fracht money) returns table
as
Begin
	declare @tab as table(sp1....)
	insert into @tab...
	select @Tab


--a) adhoc  b) Sicht  c) Proz   d) F()

--langsam--------------------------------------> schnell
a b c d
--d        b|a         c
end	




--DB Design


--Schlagworte: 
--		PK-----Beziehung--> FK
--		Datentypen
--		Normalisierung vs Redundanz

--> Diagramm



Datentypen:  OTTO 
nvarchar(50)  'OTTO'  4*2    8
varchar(50)  'OTTO'  4
char(50)     'OTTO                  ' 50
nchar(50)    'OTTO                  ' 50 * 2 --> 100

--Bestelldatum
date
datetime (ms) 
datetime2  (ns)
smalldatetime (sek)




