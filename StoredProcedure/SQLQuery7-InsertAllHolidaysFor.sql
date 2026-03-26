--SQLQuery7-InsertAllHolidaysFor.sql
USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER PROCEDURE InsertAllHolidaysFor(@year AS SMALLINT)
AS 
BEGIN 
	DECLARE @holiday		AS TINYINT = 0;
	DECLARE @holiday_id_max AS TINYINT = (SELECT MAX(holiday_id) FROM Holidays);
	WHILE @holiday <= @holiday_id_max
	BEGIN
		IF NOT EXISTS (SELECT holiday_id FROM Holidays WHERE @holiday = holiday_id)
		BEGIN
			SET @holiday += 1;
			CONTINUE;
		END
		
		DECLARE @holiday_name AS NVARCHAR(50)= (SELECT holiday_name FROM Holidays WHERE @holiday = holiday_id);
		PRINT @holiday_name
		EXEC sp_InsertHolidays @year , @holiday_name;
		
		SET @holiday += 1;
	END
	--DECLARE @holiday		AS SMALLINT = 0;
	--DECLARE @holiday_id_max AS SMALLINT = (SELECT MAX(holiday_id) FROM Holidays);

	
	--WHILE @holiday <= @holiday_id_max
	--BEGIN
		
	--	IF NOT EXISTS (SELECT holiday_id FROM Holidays WHERE holiday_id = @holiday)
	--	BEGIN
	--		SET @holiday += 1;
	--		CONTINUE;
	--	END

	--	DECLARE @holiday_name AS NVARCHAR(50);
	--	DECLARE @mounth		  AS TINYINT;
	--	DECLARE @day		  AS TINYINT;
	--	DECLARE @duration	  AS TINYINT;
		
	--	SELECT 
	--		@holiday_name = holiday_name,
	--		@mounth		  = mounth,
	--		@day		  = [day],
	--		@duration	  = duration

	--	FROM Holidays 
	--	WHERE holiday_id = @holiday;

	--	PRINT FORMATMESSAGE(N'init @holiday_name	[ %s ]' , @holiday_name);
	--	PRINT FORMATMESSAGE(N'init @mounth		[ %d ]' , @mounth);
	--	PRINT FORMATMESSAGE(N'init @day			[ %d ]' , @day);
	--	PRINT FORMATMESSAGE(N'init @duration		[ %d ]' , @duration);
		
	--	DECLARE @start_date AS DATE = N'0001-01-01';

	--	--BREAK;
	--	IF @mounth IS NULL
	--	BEGIN
			
	--		IF		@holiday_name = N'Новогодние каникулы'	SET @start_date = dbo.GetNewYearHolidaysStartDate(@year);
	--		ELSE IF @holiday_name = N'Летние каникулы'		SET @start_date = dbo.GetSummerHolidaysStartDate(@year);
	--		ELSE IF @holiday_name = N'Пасха'				SET @start_date = dbo.GetEasterDate(@year);
			
	--		PRINT FORMATMESSAGE(N'измененно на динамическую @start_date [ %s ]' , CAST(@start_date AS NCHAR(12)));
	--	END
	--	ELSE 
	--	BEGIN
	--		SET @start_date = DATEFROMPARTS(@year , @mounth , @day);
	--		PRINT FORMATMESSAGE(N'инициализация @start_date [ %s ]' , CAST(@start_date AS NCHAR(12)));
	--	END

	--	WHILE @duration > 0
	--	BEGIN
	--		EXEC InsertHolidays @holiday_name , @start_date;
	--		SET @start_date = DATEADD(DAY , 1 , @start_date);
	--		PRINT FORMATMESSAGE(N'операция и вставка @start_date [ %s ]' , CAST(@start_date AS NCHAR(12)));
	--		SET @duration  -=1;
	--	END

	--	SET @holiday +=1;
	--END
END