/*

model
create database--> model als Vorlage

msdb
DB f�r den Agent (Jobs, Auftr�ge, Zeitpl�ne, Email, Wartungspl�ne, SSIS Pakete)

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


--Was muss ich regelm��ig backup:
master t�glich 1 mal
msdb   t�glich 1 mal
model   nur bei �nderungen, besser Idee evtl Scriupt erstellen

USE [master]
GO
ALTER DATABASE [model] MODIFY FILE ( NAME = N'modeldev', SIZE = 16384KB )
GO


tempdb  gar nicht...

distribution.. wenn sie existiert t�glich

mssqlsystemressource.. hihi... geht nicht 

--Die msdb sit mit Sicherheit die schlechtete Varianten kein Backup zu haben


TIPP: Wartungsplan: t�glich vollst�ndige Sicherung der SystemDBs







*/