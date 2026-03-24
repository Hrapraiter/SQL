--SQLQuery7-GetNewYearHolidaysStartDate.sql
USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER FUNCTION GetNewYearHolidaysStartDate(@year AS SMALLINT) RETURNS DATE
AS
BEGIN
	DECLARE @new_year_date		AS DATE		= DATEFROMPARTS(@year,01,01);
	DECLARE @weekday			AS TINYINT	= DATEPART(WEEKDAY , @new_year_date); 
	DECLARE @holidays_start_date AS DATE	= DATEADD(DAY , -@weekday+1,@new_year_date);

	IF @weekday = 1 SET @holidays_start_date				= DATEADD(DAY , -2 ,@new_year_date);
	IF @weekday = 6 OR @weekday = 7 SET @holidays_start_date= DATEADD(DAY , -1 ,@new_year_date);
	
	RETURN @holidays_start_date;
END