--�berwachung: das Protokoll

--Server�berwachung: Logins �berwachen
USE [master]

GO

CREATE SERVER AUDIT SPECIFICATION [Login_Monitor]
FOR SERVER AUDIT [Security_Audit]
ADD (FAILED_LOGIN_GROUP),
ADD (SUCCESSFUL_LOGIN_GROUP)

GO

--Datenbank�berwachung

USE [Northwind]

GO

CREATE DATABASE AUDIT SPECIFICATION [Paranoia Hans]
FOR SERVER AUDIT [Security_Audit]
ADD (SELECT ON OBJECT::[dbo].[Employees] BY [Hans])

GO



