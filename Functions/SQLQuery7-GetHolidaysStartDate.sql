--SQLQuery7-GetHolidaysStartDate.sql

USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER FUNCTION GetHolidaysStartDate(@year AS SMALLINT,@holiday_name AS NVARCHAR(50)) RETURNS DATE
AS 
BEGIN

	RETURN 
	CASE @holiday_name 
	WHEN N'Новогодние%' THEN dbo.GetNewYearHolidaysStartDate(@year)
	WHEN N'Пасха'		THEN dbo.GetEasterDate(@year)
	WHEN N'Летние%'		THEN dbo.GetSummerHolidaysStartDate(@year)
	ELSE DATEFROMPARTS
			(
			@year ,
			(SELECT mounth FROM Holidays WHERE holiday_name LIKE @holiday_name),
			(SELECT [day] FROM Holidays WHERE holiday_name	LIKE @holiday_name)
			)
	END
END
