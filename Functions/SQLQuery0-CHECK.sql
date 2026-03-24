--SQLQuery0-CHECK.sql

USE PV_522_Import;
SET DATEFIRST 1;

--PRINT dbo.GetNextLearningDay(N'PV_522',N'2026-03-19')
--PRINT dbo.GetNextLearningDate(N'PV_522',N'2026-03-21')
--PRINT dbo.GetLastLearningDate(N'PV_522');
--PRINT dbo.GetNewYearHolidaysStartDate(2025);

--EXEC sp_SelectSchedule;
PRINT dbo.GetSummerHolidaysStartDate(2025);