--ContDB muss auf dem Server aktiviert werden
--Eigenst�ndige DB 

--jede DB kann nun auf Eigenst�ndigkeit ativiert werden
--Modus: Teilweise oder keine 

--Teilweise: es gibt zus�tzlich Login an der DB

EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO
USE [master]
GO
ALTER DATABASE [Northwind2] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO


USE [ContDB]
GO
CREATE USER [Otto] WITH PASSWORD=N'ppedv2019!' --nicht f�r Login!!
GO


--es gibt kein Login f�r Otto

--Login muss an die DB gehen .. nicht Standard (=master)

--cool bei Migration, weil keine Logins nachkorrigiert werden m�ssen
--#tabelle haben die Sortierung der DB geerbt

--Nachteile: keine Replikation, nicht vertrauensw�rdig --> keine Cross Abfragen


