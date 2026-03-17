-- SQLQuery3-InsertSheduleWeekdays.sql

USE PV_522_Import;
GO

ALTER PROCEDURE sp_InsertSceduleWeekdays
		@group_name			AS NCHAR(10),
		@discipline_name	AS NVARCHAR(150),
		@teacher_name		AS NVARCHAR(50),
		@start_date				AS DATE,
		@1_day AS BIT,
		@2_day AS BIT,
		@3_day AS BIT,
		@4_day AS BIT,
		@5_day AS BIT,
		@6_day AS BIT,
		@7_day AS BIT
AS
BEGIN
		SET DATEFIRST 1;

		DECLARE @group				AS	INT		=(SELECT group_id			FROM Groups			WHERE group_name=@group_name);
		DECLARE @discipline			AS	SMALLINT=(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE @discipline_name OR discipline_name = @discipline_name);
		DECLARE @number_of_lessons	AS	TINYINT	=(SELECT number_of_lessons	FROM Disciplines	WHERE discipline_name LIKE @discipline_name	OR discipline_name = @discipline_name);
		DECLARE @lesson_number		AS	TINYINT	=0;	--Номер занятия
		DECLARE @teacher			AS	SMALLINT=(SELECT teacher_id			FROM Teachers		WHERE first_name LIKE @teacher_name OR last_name LIKE @teacher_name);
		DECLARE @start_time			AS	TIME(0)	=(SELECT start_time FROM Groups WHERE group_id = @group);
		DECLARE @date				AS	DATE	=@start_date;
		DECLARE @time				AS	TIME(0)	=@start_time;
		

		PRINT @group;
		PRINT @discipline;
		PRINT @number_of_lessons;
		PRINT @teacher;
		PRINT @start_date;
		PRINT @start_time;
		PRINT N'===============================================================';
		
		
		IF  @1_day = 1 OR 
			@2_day = 1 OR
			@3_day = 1 OR
			@4_day = 1 OR
			@5_day = 1 OR
			@6_day = 1 OR
			@7_day = 1
		
			WHILE @lesson_number < @number_of_lessons
			BEGIN
				DECLARE @year_now	 VARCHAR(9) = CAST(DATEPART(YEAR , @date) AS VARCHAR(9));
				DECLARE @weekday_now INT = DATEPART(WEEKDAY , @date);

				IF  ( -- Принцип проверки дня @[number]_day включён ли день и если да то проверка
					@1_day = 1 AND @weekday_now = 1 OR 
					@2_day = 1 AND @weekday_now = 2 OR
					@3_day = 1 AND @weekday_now = 3 OR
					@4_day = 1 AND @weekday_now = 4 OR
					@5_day = 1 AND @weekday_now = 5 OR
					@6_day = 1 AND @weekday_now = 6 OR
					@7_day = 1 AND @weekday_now = 7
					)
					AND

					NOT (
					@date	= 	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'12',N'30') AS DATE)	OR -- фикс прикола дня в году
					@date	=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'12',N'31') AS DATE)  OR
					@date	>=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'01',N'01') AS DATE)  AND
					@date	<	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'01',N'12') AS DATE)
					)-- Зимние каникулы
					AND 

					NOT(
					@date	>=	CAST(FORMATMESSAGE(N'%s-%s-%s', @year_now , N'07',N'01') AS DATE)	AND
					@date	<=	CAST(FORMATMESSAGE(N'%s-%s-%s', @year_now , N'07',N'21') AS DATE)	
					) -- Летние каникулы
					AND
					256		!=	DATEPART(DAYOFYEAR , @date) 										AND -- День программиста обычно 13 сентября
					
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'01',N'04') AS DATE)	AND --  День народного единства
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'02',N'23') AS DATE)	AND --  День защитника отечества
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'03',N'08') AS DATE)	AND --  Международный женский день
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'05',N'01') AS DATE)	AND --  Праздник весны и труда
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'05',N'09') AS DATE)	AND --  День победы
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'06',N'12') AS DATE)		--  День России
					
				BEGIN
					

					--IF @date	<	CAST(FORMATMESSAGE(@format , @year_now , N'12',N'30') AS DATE)	OR @date	>	CAST(FORMATMESSAGE(@format , @year_now , N'01',N'12') AS DATE)  PRINT N'не Зимние каникулы '
					--IF @date	<	CAST(FORMATMESSAGE(@format , @year_now , N'07',N'01') AS DATE)  OR @date	>	CAST(FORMATMESSAGE(@format , @year_now , N'07',N'21') AS DATE)	PRINT N'не Летние каникулы '
					
					--IF 256		!=	DATEPART(DAY , @date) 											PRINT N'не День программиста обычно 13 сентября'
																								  	
					--IF @date	!=	CAST(FORMATMESSAGE(@format , @year_now , N'01',N'04') AS DATE)	PRINT N'не День народного единства'
					--IF @date	!=	CAST(FORMATMESSAGE(@format , @year_now , N'02',N'23') AS DATE)	PRINT N'не День защитника отечества'
					--IF @date	!=	CAST(FORMATMESSAGE(@format , @year_now , N'03',N'08') AS DATE)	PRINT N'не Международный женский день'
					--IF @date	!=	CAST(FORMATMESSAGE(@format , @year_now , N'05',N'01') AS DATE)	PRINT N'не Праздник весны и труда'
					--IF @date	!=	CAST(FORMATMESSAGE(@format , @year_now , N'05',N'09') AS DATE)	PRINT N'не День победы'
					--IF @date	!=	CAST(FORMATMESSAGE(@format , @year_now , N'06',N'12') AS DATE)	PRINT N'не День России'

					SET @time = @start_time;

					PRINT FORMATMESSAGE(N'%i, %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY, @date), CAST(@time AS NVARCHAR(12)));
					EXEC sp_InsertLesson @group , @discipline , @teacher , @date , @time OUTPUT, @lesson_number OUTPUT;
					
					PRINT FORMATMESSAGE(N'%i, %s %s %s', @lesson_number, CAST(@date AS NVARCHAR(12)), DATENAME(WEEKDAY, @date), CAST(@time AS NVARCHAR(12)));
					EXEC sp_InsertLesson @group , @discipline , @teacher , @date , @time OUTPUT, @lesson_number OUTPUT;
				END

				SET @date = DATEADD(DAY, 1, @date); 
			END
END