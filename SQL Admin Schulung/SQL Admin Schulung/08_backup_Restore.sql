/*

F�lle f�r Backup Restore

1. Versehentliches �ndern/L�schen von Daten --< der logische Fehler
2. Ausfall einer Datei mdf oder ldf.. Server l�uft , aber DB nicht mehr
3. Ausfall des Servers, aber Dateien sind da
4. Alles weg--> Fall f�r Restore
5. Wenn ich weiss, dass gleich was passiert

--mit geringst m�glichen Datenverlust

Vorab immer kl�ren:
-Wie lange darf der Server / DB ausfallen?
--> Reaktionszeit mitbeachten + Dauer des Restore

--Wieviel darf der Datenverlust in Zeit sein?
--Regel Backupstrategie

--Wie kann man Backupen?

--Was ist f�r ein komische Wiederherstellungsmodel?


Nur die Sicherung des TLog leert das Tlog

Voll
	wie BULK aber deutlich detailierter
	man kann auf Sek restoren!
	man muss das Tlog sichern
	jede DB ist per default auf FULL eingestellt, weil model...

Bulk
	wie Model einfach, aber es werden keine TX gel�scht
	auf Sek restoren, wenn kein Bulk lief
	man muss das Tlog sichern!

Simple
	jede TX wird nach Commit und Checkpoint aus dem Log autom entfernt
	zeichnet jeden INS UP DEL auf, Bulk Befehle aber nur sehr einfach


FULL Backup
Checkpoint, Es werden Datenseiten gesichert aber auch die Info; Dateien , Pfade und Gr��en
= ein Zeitpunkt

Diff Backup
merkt sich ge�nderte Bl�cke seit Vollsicherung
also Diff zu V
= ein Zeitpunkt

TLog Sicherung 
merkt sich die Anweisungen
beim restore wird alles nachgemacht.


*/
--FULL
BACKUP DATABASE [Northwind]
TO  DISK = N'D:\_BACKUP\Northwind.bak' 
WITH NOFORMAT, NOINIT,  
NAME = N'Northwind-Vollst�ndig', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--DIFF
BACKUP DATABASE [Northwind] 
TO  DISK = N'D:\_BACKUP\Northwind.bak' 
WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  
NAME = N'Northwind-Diff', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--TLOG
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind.bak' 
WITH NOFORMAT, NOINIT,  
NAME = N'Northwind-Tlog', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO



/*

chronologischer Verlauf
V  TTT  D  TTT D TTT D TTT

letzter Zustand im Backup retoren
V					 D TTT


--was wenn kein D
V  TTT    TTT  TTT  TTT

V TTT TTT TTT

--was wenn ein T defekt w�re

V TT!T! TTT TTT
V TT


V TT!T! TT!T! D  TTT
V             D  TTT

Was ist der schnellste Restore ?
das V alleine--> je h�ufiger das V desto besser

Wie lange dauert der Restore des vorletzten T?
so lange die Anweisungen eben dauern.. macht wie Makro alles nach..
wir wollen nicht wirklich viele T restoren



*/

--FALL 1: Logischer Fehler. DB ok, aber Daten teilwe ver�ndert
--Speziell: alle Kunden in London

--Idee restore der DB unter anderen Namen
--Fragemsicherung ausschalten
--Dateiname oder Pfade anpassen, DB umbenennen
USE [master]
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 13,  MOVE N'Northwind' TO N'D:\_SQLDB\northw2nd.mdf',  MOVE N'Northwind_log' TO N'D:\_SQLDB\northwn2d.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 14,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 15,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 16,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind2] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 17,  NOUNLOAD,  STATS = 5

GO

--Fall 2: Server l�uft , aber eine Datei weg und Fall 3
--D:\_SQLDB

ALTER DATABASE [Northwind2] SET  OFFLINE
GO
--DB Trennen

ALTER DATABASE northwind2 SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
EXEC master.dbo.sp_detach_db @dbname = N'northwind2'
GO
--Wenn eine Datei fehlt: ldf
USE [master]
GO
CREATE DATABASE [Northwind2] ON 
( FILENAME = N'D:\_SQLDB\northw2nd.mdf' )
 FOR ATTACH
GO


--wenn mdf fehlt... Arbeitsamt!--alles futsch

--Fall 4: regul�rer Restore der laufenden DB
--mit geringst m�glichen Datenverlust

--Letze Sicherung war 10:25
--die wollen wir wieder haben
--Restore von V D TTT und DB ersetzen Option und Fragementsicherung deaktiveren

--10:25 letzte Sicherung

--11:03 Error.. falscher Update

--11:19

--11:30 n�chste T Sicherung

--Idee:
--manuell eine T Sicherung um 11:19
--Restore auf 11:02
--per Zeitache auf Sekunde...
--hellgr�n=ungesicherte Teil des Log= Fragment

--Idee.. alle Leute von der DB trennen
--       Sicherung des Fragment
--Rstore auf Sekunde

USE [master]
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\Northwind_LogBackup_2021-10-20_11-27-08.bak' WITH NOFORMAT, NOINIT,  NAME = N'Northwind_LogBackup_2021-10-20_11-27-08', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 13,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 14,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 15,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 16,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind.bak' WITH  FILE = 17,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Northwind] FROM  DISK = N'D:\_BACKUP\Northwind_LogBackup_2021-10-20_11-27-08.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2021-10-20T11:09:51'
ALTER DATABASE [Northwind] SET MULTI_USER

GO


--Fall 5 : Wenn man weiss, dass was gleich passieren kann

--DB mit 100GB
--MDF 90GB und 10 GB ldf

-- Idee: Backup=lesbare DB  = Snapshot DB

--HDD (frei 10GB).. geht
--HDD (frei 1GB).. geht
--HDD (frei 10MB).. geht
--es werden trotzdem auf der HDD 90GB weitere Datei angelegt
--Sparse files

-- Create the database snapshot
CREATE DATABASE DBNAME ON
( NAME = Northwind, --logischer Dateiname der OrgDB
FILENAME = 'D:\_SQLDB\nwindsn1142.mdf' )--neue Datei des Snapshot
AS SNAPSHOT OF OrgDB;
GO


CREATE DATABASE Nwind_1142 ON
( NAME = Northwind, --logischer Dateiname der OrgDB
FILENAME = 'D:\_SQLDB\nwindsn1142.mdf' )--neue Datei des Snapshot
AS SNAPSHOT OF Northwind;
GO



--restore from snapshot

--Kann man die Org Db backupen bei Snapshotsicherung?
--ja

--kann man den Snapshot sichern?
--n�

--Snapshot restoren?
--h�.. n�

--kann ich die Org DB normal restoren?
--N�, nur wenn der Snapshot voerh gel�scht

--kann man mehr Snapshots haben?
--ja

--f�r den Restore from snapshot:
--keiner auf dem Snapshot und keiner auf der OrgDB


--Aktivit�tsmonitor
use master

--kill 74

restore database northwind
from database_snapshot = 'Nwind_1142'

--fertisch...






