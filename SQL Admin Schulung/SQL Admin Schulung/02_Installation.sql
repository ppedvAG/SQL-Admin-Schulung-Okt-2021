/*
RAM

CPU (MAXDOP Wert gilt f�r: pro ABfrage)

HDD (Pfade)
Bin�rkranm: C:\Program Files\Microsoft SQL Server\ kann man lassen
Warum f�r Log (ldf) und Daten(mdf) getrennte Pfade

Trenne Daten von Logfile physikalisch (HDD)-- Standardwert
--eigtl pro DB 

MAXDOP
Max Anzahl der Kerne pro Abfrage (Anzahl der Kerne max 8)


Arbeitsspeicher
Gesamter RAM minus OS ber�cksichtigen

Security
sa komplexes Kennwort
gemischt Auth, nur wenn notwendig
Windows Admins sind nicht autom. SQL Admin
--ausser im Emergenc Modus


Features  (Instanz~ , Freigegeben Funktionen)

Datbankengine plus Volltextsuche und Replikation
+ Konnektivit�t der Clienttools


Dienstkonten
	Volumewartungstask
		SQL Server kann ohne auszunullen Dateien vergr��ern
		aus Securitygr�nden evtl nicht machen
		einem guten Admin ist das egal

	Dienste
	verwaltete Dienstkonten:
	NT Service\SQLAgent$FE : lokales Konto --> verwende Computerkonto
							 �ndert Kennw�rter vr ABlauf der Kennwortrichtlinie
			-> man kann auch DomBenutzerkonten verwenden..keine besonderern Rechte
			 --> der lokale zugriff ist immer das verw Dienstkonto



tempdb
eigtl eigene HDDs.. und trenne Log von Daten
sollte soviele Daten-Dateien haben wir Cores.. nicht mehr als 8


Filestreaming


Instanzen:



Standardinstanz: Port: 1433
 Aufruf: "Rechnername"

 Client denkt immer in "1433"

 benannte Instanz (HR)
 Aufruf: "Rechnername\Instanzname" Port: random


 Browserdienst einmal pro Rechern: verwendet Port 1434 UDP
 teilt dem Client den Port mit
 per default auf deaktiviert
 Firewall?










*/