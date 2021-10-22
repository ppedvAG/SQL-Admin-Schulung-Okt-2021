--Überwachung: das Protokoll

--Serverüberwachung: Logins überwachen
USE [master]

GO

CREATE SERVER AUDIT SPECIFICATION [Login_Monitor]
FOR SERVER AUDIT [Security_Audit]
ADD (FAILED_LOGIN_GROUP),
ADD (SUCCESSFUL_LOGIN_GROUP)

GO

--Datenbanküberwachung

USE [Northwind]

GO

CREATE DATABASE AUDIT SPECIFICATION [Paranoia Hans]
FOR SERVER AUDIT [Security_Audit]
ADD (SELECT ON OBJECT::[dbo].[Employees] BY [Hans])

GO



