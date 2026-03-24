--SQLQuery7-GetSummerHolidaysStartDate.sql
USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER FUNCTION GetSummerHolidaysStartDate(@year AS SMALLINT) RETURNS DATE
AS
BEGIN
	DECLARE @start_date		AS DATE		= DATEFROMPARTS(@year,08,01);
	DECLARE @weekday		AS TINYINT	= DATEPART(WEEKDAY , @start_date);
	RETURN DATEADD(DAY, -@weekday+1 , @start_date);

END