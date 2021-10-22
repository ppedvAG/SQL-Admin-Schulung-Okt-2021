/*

NGR IX zusätzliche Menge an DS und Seiten --> Telefonbuch
Sortierte Form-- Baum drauf

where...
gut bei rel wenigen Ergebnissen
ideal: PK ID Werte GUID = 
bescheuert: Vorname, Geschlecht, Religion


Gr IX = Tabelle in sortierter Form und bleibt sortiert
gibts nur 1mal pro Tabelle

where
gut bei: auch größeren Ergebnismengen vor allem wenn sortiert oder Bereiche
--aber auch bei ID Werten

--GR IX unbedingt für Bereichsabfragen reservieren



*/

--Tabelle Best

--SCAN  (Abis Z)  SEEK (Herauspicken)

--Heap --- mit CLIX kein Heap sondern nur noch CL IX
-- NC IX... IX SEEK IX SCAN

select * from best where bestnr = 100 --eigtl SCAN --TABLE SCAN

--der PK wird automatisch immer als CL IX angelegt
--aber die meisten Suchen (Bereich) werden BDatum einen CL IX brauchen

--Tipp: zuerst den GR IX anlegen, dann PK


/*

Tabelle mit 3 Spalten A B C kann auch 1000 Indizes haben
Welche, die sich überlappen (AB ABC) oder auch fehlende
Insofern:

Problem fehlende Indizes
		überflüssige Indizes
		schlecht performende Indizes

Tools zum Auffinden: Profiler, QueryStore + Datenbankoptimierungsassistent (DT)

Der DTA benötigt eine Aufzeichnung eines typischen Workloads um 
brauchbare Vorschläge für die DB zu entwicklen.

Das kann dauer ;-) Nicht abbrechen, denn sonst bleiben Indizes übrgig
_dta_... diese sind unsichtbar und nur per TSQL auffindbar.


Alternativ kan man auch DMVs verwenden allerdings ist dies 
nur beschränkt aussagekräftig. Zum Beisp. kann man keine konkreten
Indexvorschläge herausziehen


*/

--DMV

select * from sys.dm_db_index_usage_stats











select object_name(i.object_id) as TableName
      ,i.type_desc,i.name
      ,us.user_seeks, us.user_scans
      ,us.user_lookups,us.user_updates
      ,us.last_user_scan, us.last_user_update
  from sys.indexes as i
       left outer join sys.dm_db_index_usage_stats as us
                    on i.index_id=us.index_id
                   and i.object_id=us.object_id
 where objectproperty(i.object_id, 'IsUserTable') = 1
go


select p.query_plan
   from sys.dm_exec_cached_plans
        cross apply sys.dm_exec_query_plan(plan_handle) as p
  where p.query_plan.exist(
         'declare namespace
          mi="http://schemas.microsoft.com/sqlserver/2004/07/showplan";
            //mi:MissingIndexes')=1
go
