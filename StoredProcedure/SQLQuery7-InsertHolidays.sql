--SQLQuery7-InsertHolidays.sql
USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER PROCEDURE InsertHolidays(@holiday_name AS NVARCHAR(50) , @date AS DATE)
AS
BEGIN
	DECLARE @holiday AS SMALLINT = (SELECT holiday_id FROM Holidays WHERE @holiday_name = holiday_name);
	IF NOT EXISTS (SELECT [date] FROM DaysOFF WHERE @holiday = holiday AND @date = [date])
		INSERT DaysOFF ([date] , [holiday]) VALUES (@date , @holiday);
END