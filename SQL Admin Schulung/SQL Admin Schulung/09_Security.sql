--Zuerst braucht man ein Login

--um in eine DB zu kommen, muss man aber auch als User in der
--jeweiligen DB enthalten sein.
--nur die SID ist verantwortlich: = UserMapping / Benutzerzuordnung



--SUSI
USE [Northwind]
GO
CREATE USER [Susi] FOR LOGIN [Susi]
GO
USE [master]
GO
CREATE LOGIN [Hans] WITH PASSWORD=N'123', 
DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Hans] FOR LOGIN [Hans]
GO


--SCHEMA = ORDNER

USE Northwind
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO


USE Northwind
GO
CREATE SCHEMA [MA] AUTHORIZATION [dbo]

create table it.mitarbeiter (id int, itma int)

create table ma.mitarbeiter (id int, mama int)

create table it.projekte (id int, itpro int)

create table ma.projekte (id int, mapro int)

--Hasn und Susi sollen in ihren Schema select ausübe3n dürfen

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[MA] TO [Susi]
GO


use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Hans]
GO


use [Northwind]
GO
GRANT SELECT ON [IT].[projekte] TO [Susi]
GO

--man sieht keine vererbten Rechte ausser über effektive anzeigen lassen


select * from mitarbeiter --geht nicht

--der exakte Name einer Tabelle ist der...
select * from Northwind..orders

select * from mitarbeiter --> dbo.mitarbeiter

--Jeder User kann ein Defauzltschema haben.. default = dbo


USE [Northwind]
GO
ALTER USER [Susi] WITH DEFAULT_SCHEMA=[MA]
GO
ALTER USER [HANS] WITH DEFAULT_SCHEMA=[IT]
GO


use [Northwind]
GO
GRANT CREATE TABLE TO [Susi]
GO


---ROLLEN
-- = Gruppen
--Serverrollen --administrative Rechte
--public = jeder

--Datebankrollen 

USE [Northwind]
GO
CREATE ROLE [ITGruppe] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [ITGruppe] ADD MEMBER [Hans]
GO


use [Northwind]
GO
REVOKE SELECT ON SCHEMA::[IT] TO [Hans] AS [dbo]
GO
use [Northwind]
GO
GRANT SELECT ON SCHEMA::[IT] TO [ITGruppe]
GO



USE [master]
GO
CREATE LOGIN [Peter] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [Northwind]
GO
CREATE USER [Peter] FOR LOGIN [Peter]
GO
USE [Northwind]
GO
ALTER USER [Peter] WITH DEFAULT_SCHEMA=[IT]
GO
USE [Northwind]
GO
ALTER ROLE [ITGruppe] ADD MEMBER [Peter]
GO





--Hans soll Sichten anlegen dürfen

use [Northwind]
GO
GRANT CREATE VIEW TO [Hans]
GO
use [Northwind]
GO
GRANT ALTER ON SCHEMA::[IT] TO [Hans]
GO


use [Northwind]
GO
DENY SELECT ON [dbo].[Employees] TO [Hans]
GO


--Neuer Mitarbeiter: 
--Peter soll wie hans arbeiten können


create view it.v1
as
select * from IT.mitarbeiter


select * from dbo.employees

----

create view it.emp
as
select * from dbo.employees




select * from (select * from dbo.employees) emp --geht nicht

select * from IT.emp --geht ????? wg Besitzverkettung

--> Idee i der Sicht alle sensiblen Daten weglassen

--nie : lass normalen Usern nie Sichten, Proz oder F() erstellen zu 

--Besitzverkettung gibts auf DB übergreifend ist aber inaktiv


--Gib nie jemanden den Schemabesitz
-- Besitzverkettung
-- Besitzer darf alles
-- wechselt der BEsitzer sind alle Rechte weg


----Chantal Sekretärin 
--alle MA bekommen 10% mehr
--Windows Auth (Chantal) ++10%
--auf dem NB des Chefs mit der Software klappts
--im SSMS klappts nicht

--> Anwendungsrolle

--besitzer immer dbo

   dbo  dbo dbo  dbo  dbo  dbo --> Besitzverkettung
-->V5-->v4-->V3-->V2-->v1-->T1

--in diesem fall zählt nur das Recht des aufgerufenen Objekt


USE [Northwind]
GO
CREATE APPLICATION ROLE [Gehaltsrolle] 
WITH DEFAULT_SCHEMA = [dbo], PASSWORD = N'ppedv2019!'
GO


select * from orders

sp_setapprole 'Gehaltsrolle', 'ppedv2019!'

select SID,[name] from syslogins


--Was passiert eigtl wenn:
--Server HV-SQL1  Backup der DB X und restoren auf Server HV-SQL2


--in der DB ist ein User der auf best lesen kann
----seit DB auf HV-SQL2 liegt klagt der User, dass nix mehr geht

--Falls man mit NT Konten arbeitet ist es kein großer Umstand

select * from syslogins


--mit NT KOnten ist es sehr einfach , weil SQL die NT SID verwendet

--bei SQL Konten?
--müssen repariert werden

--nur mit Rollen gearbeitet


--wenn nicht mit Gruppen

sp_change_users_login 'Report'

--er findet Otto

sp_change_users_login 'Auto_fix', 'Otto', 'Otto', 'ppedv2019!'

--wenn Otto aber schon exisitiert (aber hat ne andere SID)

sp_change_users_login 'UPdate_one', 'Otto', 'Otto'

--noch besser... 

sp_help_revlogin


