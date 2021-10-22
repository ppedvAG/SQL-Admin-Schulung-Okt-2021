/*


Ansicht Registrierte Server
Gruppe anlegen
Server registrieren

Vorteile
Abfragen auf der gesamten Gruppe ausführen lassen
Richtlinien auf der gesamten Gruppe prüfen lassen
Doppelklick - Verbindung im SSMS herstellen



Richtlinien

Facets = überprüfbare Objekte
Bedingungen= das Ziel das ereicht werden soll zb RecoveryModel = Full
Richtlinien = Anwendung der Bedingungen

Vorteile: 
Schnelle Prüfung auf Vorgaben 
Teilweise sofortige Umsetzung der Vorgaben auf alle DBs oder 
per reg. Server Firmenweit



Datensammler
anstatt Daten manuell zu sammlen per TSQL, was durchaus seine Vorteile hat,
kann dies der Datensammler erledigen.

Vorteil: grafische Auswertung auch über längeren Zeitraum mit drilldown

Nachteil: Ressourcenhungrig



Perfmon und Profiler

Trick: 
Aufzeichnung des Profiler öffnen ! (Startzeiten eines STatements müssen enthalten sein)
Datei Leistungsdaten importieren...

Cool: Das Übereinanderlegen der grafische Perfmon auswertung und Profiler 
		Zeitliches Korresponieren



