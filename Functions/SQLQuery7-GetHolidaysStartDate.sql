--SQLQuery7-GetHolidaysStartDate.sql

USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER FUNCTION GetHolidaysStartDate(@holiday_name AS NVARCHAR(50), @year AS SMALLINT) RETURNS DATE
AS 
BEGIN 
	DECLARE @holiday AS SMALLINT = (SELECT holiday_id FROM Holidays WHERE @holiday_name = holiday_name);
	RETURN (SELECT [date] FROM DaysOFF WHERE @holiday = holiday AND DATEPART(YEAR , [date]) = @year);
END
