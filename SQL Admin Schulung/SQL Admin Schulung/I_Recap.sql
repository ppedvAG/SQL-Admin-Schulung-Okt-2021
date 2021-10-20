/*


Kontrolliere den HV-SQL1 nach best practice Gedanken

Task Manager:
CPU Kerne:4    Socket: 1
RAM: 5 GB
HDD: 1  <--> Trenne Log von Daten physikalisch(HDDs)

Arbeitsspeicher
MIn RAM: 0 der Wert gilt nur , wenn er erreicht wird
MAX RAM: 2,1 PB. keine gute Idee besser OS abziehen von Gesamt
				 FÜr OS ca 2 GB 
				 Idealer ca 3000 MB

CPU Kerne im SQL ..NUMA 1 Knoten  4 Kerne ...ok


MAXDOP: wieviel CPU Kerne kann eine Abfrage verwenden
		einen oder alle!
		Regel: nie mehr als 8 sonst Anzahl der kerne


HV-SQL1: statt 4 nur 2 


tempdb
	soviele Datendateien haben wie Kerne
HV-SQL1: statt 4 Dateien nur 2 

TIPP::: achte darauf, dass bei Änderungen an Hardware (VMs)
		die Einstellungen des SQL Server korrigiert werden

Pfade: Ok.. auch wenn nur ein Laufwerk




*/