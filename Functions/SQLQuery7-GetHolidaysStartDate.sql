--SQLQuery7-GetHolidaysStartDate.sql

USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER FUNCTION GetHolidaysStartDate(@year AS SMALLINT,@holiday_name AS NVARCHAR(50)) RETURNS DATE
AS 
BEGIN
	DECLARE @start_date AS DATE;
	IF		@holiday_name LIKE N'Новогодние%'	SET @start_date = dbo.GetNewYearHolidaysStartDate(@year);
	ELSE IF @holiday_name = N'Пасха'			SET @start_date = dbo.GetEasterDate(@year);
	ELSE IF @holiday_name LIKE N'Летние%'		SET @start_date = dbo.GetSummerHolidaysStartDate(@year);
	ELSE	
		SET @start_date = DATEFROMPARTS
							(
							@year ,
							(SELECT mounth FROM Holidays WHERE holiday_name LIKE @holiday_name),
							(SELECT [day] FROM Holidays WHERE holiday_name	LIKE @holiday_name)
							)
	RETURN @start_date;
	--RETURN 
	--CASE @holiday_name 
	--WHEN N'Новогодние%' THEN dbo.GetNewYearHolidaysStartDate(@year)
	--WHEN N'Пасха'		THEN dbo.GetEasterDate(@year)
	--WHEN N'Летние%'		THEN dbo.GetSummerHolidaysStartDate(@year)
	--ELSE DATEFROMPARTS
	--		(
	--		@year ,
	--		(SELECT mounth FROM Holidays WHERE holiday_name LIKE @holiday_name),
	--		(SELECT [day] FROM Holidays WHERE holiday_name	LIKE @holiday_name)
	--		)
	--END
END
