/*


Ansicht Registrierte Server
Gruppe anlegen
Server registrieren

Vorteile
Abfragen auf der gesamten Gruppe ausf�hren lassen
Richtlinien auf der gesamten Gruppe pr�fen lassen
Doppelklick - Verbindung im SSMS herstellen



Richtlinien

Facets = �berpr�fbare Objekte
Bedingungen= das Ziel das ereicht werden soll zb RecoveryModel = Full
Richtlinien = Anwendung der Bedingungen

Vorteile: 
Schnelle Pr�fung auf Vorgaben 
Teilweise sofortige Umsetzung der Vorgaben auf alle DBs oder 
per reg. Server Firmenweit



Datensammler
anstatt Daten manuell zu sammlen per TSQL, was durchaus seine Vorteile hat,
kann dies der Datensammler erledigen.

Vorteil: grafische Auswertung auch �ber l�ngeren Zeitraum mit drilldown

Nachteil: Ressourcenhungrig



Perfmon und Profiler

Trick: 
Aufzeichnung des Profiler �ffnen ! (Startzeiten eines STatements m�ssen enthalten sein)
Datei Leistungsdaten importieren...

Cool: Das �bereinanderlegen der grafische Perfmon auswertung und Profiler 
		Zeitliches Korresponieren



