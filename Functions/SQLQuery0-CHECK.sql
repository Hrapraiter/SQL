--SQLQuery0-CHECK.sql

USE PV_522_Import;
SET DATEFIRST 1;

EXEC sp_SelectSchedule;
PRINT dbo.GetNextLearningDay(N'PV_522',N'2026-03-19')


--PRINT dbo.GetLastLearningDate(N'PV_522');