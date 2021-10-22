/*

Live
Task Manager - Ressourcenmonitor

Taskmanager
CPU, RAM, Netzwerk, HDD

Ressourcemonitor
welche Datei ?


Was aber wenn hardwaretechn. alles ok?

--> SQL Server: Locks.. Aktivitätsmonitor

select * from sysprocesses --alle Prozesse unter SPID 51 ist SQL Server intern

teakids.exe  mslaugh.exe  (als Admin)
Antivirentools


DMV.. Systemsichten

select * from sys.dm_os_wait_Stats order by 3 desc

select * from sys.dm_os_... (SQL Server)
select * from sys.dm_db_.... (Datenbank)

select * from sys...

Vorsicht: Infos aus den DMVS werden nach Neusart auf 0 zurückgesetzt

Historisches Problem

Perfom (NT) SQL Server integriert hier viele Messwerte
*/
select * from sys.dm_os_performance_counters

*/

--Profiler zeichnet TSQL auf





*/

---Abfrage-->Queue-->Worker (FIFO)--->

select * from sys.dm_os_wait_stats
-->|0ms......Ressourcen anfragen.... ...|ms.......|70ms
---------------------------------------->.........>signaltime 20ms
---------------------------------------->70-20ms = 50ms

-------- SUSPENDED---------------------->RUNNABLE-->RUNNING

--Die Zeiten sind leider kummilierend seit dem Neustart
--sigalzeit darf nur max 20% der gesamten zeit sein , sonst CPU Engpass


--