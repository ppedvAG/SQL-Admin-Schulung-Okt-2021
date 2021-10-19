/*

model
create database--> model als Vorlage

msdb
DB für den Agent (Jobs, Aufträge, Zeitpläne, Email, Wartungspläne, SSIS Pakete)

master
Infos zu: Datenbanken
	      Logins
		  Konfiguration


tempdb
	#tabellen
	Zeilenversionierung
	Auslagerungen
	Sortierarbeiten
	Indizes


distribution
	nur da, wenn Replikation


mssqlsystemressources
	blackbox.. Messinfos


--Was muss ich regelmäßig backup:
master täglich 1 mal
msdb   täglich 1 mal
model   nur bei Änderungen, besser Idee evtl Scriupt erstellen

USE [master]
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modeldev', SIZE = 16384KB )
GO


tempdb  gar nicht...

distribution.. wenn sie existiert täglich

mssqlsystemressource.. hihi... geht nicht 

--Die msdb sit mit Sicherheit die schlechtete Varianten kein Backup zu haben


TIPP: Wartungsplan: täglich vollständige Sicherung der SystemDBs







*/