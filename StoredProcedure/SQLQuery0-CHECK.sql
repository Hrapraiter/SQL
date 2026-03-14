--SQLQuery0-CHECK.sql

USE PV_522_Import;
SET DATEFIRST 1

--DELETE FROM Schedule --WHERE discipline = (SELECT discipline_id FROM Disciplines WHERE discipline_name = N'HTML/CSS')

EXEC sp_InsertScedule N'PV_522' , N'%Win%C++' , N'Юыху' , N'2025-12-09'
EXEC sp_InsertScedule N'PV_522' , N'%Win%C#' , N'Юыху' , N'2025-12-30'
--EXEC sp_InsertScedule N'PV_522' , N'%Windows%C++',N'Юыху', N'2025-12-08';
EXEC sp_SelectSchedule;