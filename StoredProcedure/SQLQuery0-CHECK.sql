--SQLQuery0-CHECK.sql

USE PV_522_Import;
SET LANGUAGE RUSSIAN
SET DATEFIRST 1

DELETE FROM Schedule --WHERE discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name = N'HTML/CSS')

--EXEC sp_InsertSceduleWeekdays 
--	N'PV_522' , N'%Win%C++' , N'Олег' , N'2024-09-10', -- проверка дня програмиста
--	0 , 1 , 0 , 1 , 0 , 1 , 0
----  Пн, Вт, Ср, Чт, Пт, Сб, Вс

--EXEC sp_InsertSceduleWeekdays 
--	N'PV_522' , N'%Win%C#' , N'Олег' , N'2025-12-30', -- проверка зимних каникул
--	0 , 1 , 0 , 1 , 0 , 1 , 0

--EXEC sp_InsertSceduleWeekdays 
--	N'PV_522' , N'%ADO.NET' , N'Олег' , N'2026-07-01', -- проверка летних каникул
--	0 , 1 , 0 , 1 , 0 , 1 , 0

--EXEC sp_InsertSceduleWeekdays 
--	N'PV_522' , N'%ADO.NET' , N'Олег' , N'2026-07-01', -- проверка защиты от неадекватного использования поведения
--	0 , 0 , 0 , 0 , 0 , 0 , 0

--EXEC sp_InsertScedule N'PV_522' , N'%Win%C#' , N'Олег' , N'2025-12-30'
--EXEC sp_InsertScedule N'PV_522' , N'%Windows%C++',N'Олег', N'2025-12-08';
--DELETE FROM DaysOFF;

--EXEC InsertAllHolidaysFor 2025;
--SELECT [date] , holiday_name  FROM  DaysOFF , Holidays WHERE holiday_id = holiday;


--EXEC sp_InsertScedule N'PV_522' , N'%Win%C++' ,			N'Олег' , N'2025-12-09';
--EXEC sp_InsertScedule N'PV_522' , N'%Win%C#' ,			N'Олег' , N'2025-12-30';
--EXEC sp_InsertScedule N'PV_522' , N'%MS SQL Server' ,	N'Олег' , N'2026-01-20';
--EXEC sp_SelectSchedule;

--DELETE FROM DaysOFF
EXEC InsertAllHolidaysFor 2026;
SELECT [date] , holiday_name FROM DaysOFF , Holidays WHERE holiday = holiday_id;