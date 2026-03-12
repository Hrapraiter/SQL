--SQLQuery5-ALTER Shedule.sql

USE PV_522_Import;


--ALTER TABLE Shedule
--DELETE FROM Shedile ;
DECLARE @group				AS INT		=(SELECT group_id			FROM Groups			WHERE group_name = N'PV_522');
DECLARE @discipline			AS SMALLINT =(SELECT discipline_id		FROM Disciplines	WHERE discipline_name LIKE N'%ADO.NET');
DECLARE @number_of_leasson	AS TINYINT	=(SELECT number_of_lessons FROM Disciplines	WHERE discipline_name LIKE N'%ADO.NET');
DECLARE @leasson_number		AS TINYINT	=0;
DECLARE @teacher			AS SMALLINT =(SELECT teacher_id		FROM Teachers		WHERE first_name=N'Олег');
DECLARE @start_date			AS DATE		=N'2026-03-03';
DECLARE @start_time			AS TIME(0)	=N'18:30';
DECLARE @date				AS DATE		=@start_date;
DECLARE @time				AS TIME(0)	=@start_time;

PRINT @group;
PRINT @discipline;
PRINT @teacher;
PRINT @start_date;
PRINT @start_time;
PRINT N'================================================';

--PRINT @date;
--PRINT @time;
--PRINT @number_of_leasson
SET LANGUAGE 'RUSSIAN';
SET DATEFIRST 1

WHILE @leasson_number < @number_of_leasson
BEGIN
	
	PRINT FORMATMESSAGE(N'%i %s %s %s',@leasson_number ,CONVERT(VARCHAR(12),@date) , DATENAME(WEEKDAY , @date) , CONVERT(VARCHAR(9),@time));
	SET @time = DATEADD(MINUTE , 95 , @time);
	SET @leasson_number += 1;
	
	PRINT FORMATMESSAGE(N'%i %s %s %s',@leasson_number ,CONVERT(VARCHAR(12),@date) , DATENAME(WEEKDAY , @date) , CONVERT(VARCHAR(9),@time));
	--IF NOT EXISTS (SELECT leassin_id FROM Shedule WHERE [date] = @date AND [time] = @time))
	SET @leasson_number += 1;
	
	--SET @time = @start_time;
	SET @date = DATEADD(DAY , IIF(DATEPART(WEEKDAY , @date)=6 , 3 , 2) , @date);
	--							DATEPART(WEEKDAY, @date) == 6 ? 3 : 2

END	

-- CAST(value AS TYPE);		явное преобразование значения (value) в желаемый тип (TYPE);
-- DATENAME(PART , date);   Возвращает название фрагмента даты (месяца , дня недели);
-- DATEPART(PART , date);	Возвращает числовое значение фрагмента даты (месяца , дня недели);
-- DATEADD(UNIT , amount , date OR time); Добавляет заданное колличество (amount) единиц времени (UNIT) к дате или времени (date OR time) 
-- IIF(CONDITION , value_1 , value_2); Conditional Trenary Operator : Eсли условие (CONDITION) вернуло TRUE , то IIF возращает value_1 , в противном случае value_2


SELECT * FROM Schedule