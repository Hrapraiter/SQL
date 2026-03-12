--SQLQuery5-HW INSERT to Shedule.sql


USE PV_522_Import;

--SET DATEFORMAT = 'dmy';


--PRINT DATEPART(weekday , N'12/03/2026')

--DECLARE @date DATETIME2 = '03/12/2025 18:30:00';

--DECLARE @i INT = 0;

--WHILE @i < 14
--BEGIN

--	DECLARE @string_date VARCHAR(20) = REPLACE(CONVERT(VARCHAR(20) , @date , 104) , '.' , '/');

--	PRINT FORMATMESSAGE('%s WD -> %d' , @string_date , DATEPART(weekday , @date))
--	SET @date = DATEADD(day , 1 , @date)
--	SET @i += 1

--END

SET DATEFIRST 1;


DECLARE @current_date			DATE		= '03/12/2025';
DECLARE @date_today				DATE		= CAST(GETDATE() AS DATE);
DECLARE @discipline_id 			INT			= 1;
DECLARE @number_of_leassons		INT;
DECLARE @discipline_id_max		INT			= 7;

DECLARE @group					INT;
DECLARE @teacher				INT;
DECLARE @spent					BIT			= 1;

SELECT @group = group_id FROM Groups WHERE group_name = N'PV_522'

SELECT @teacher = teacher_id 
FROM Teachers 
WHERE last_name	= N'Ковтун' 
AND first_name	= N'Олег'
AND middle_name = N'Анатольевич'

DECLARE @Shedule TABLE -- для тестов
(
	leasson_id		BIGINT			PRIMARY KEY IDENTITY(1,1),
	discipline		SMALLINT	NOT NULL,
	[group]			INT			NOT NULL,
	teacher			INT			NOT NULL,
	[date]			DATE		NOT NULL,
	[time]			TIME(0)		NOT NULL,
	spent			BIT			NOT NULL
);

WHILE @discipline_id <= @discipline_id_max
BEGIN
	SELECT @number_of_leassons = number_of_lessons 
	FROM Disciplines
	WHERE @discipline_id  = discipline_id

	WHILE @number_of_leassons > 0
	BEGIN
		IF @current_date > @date_today SET @spent = 0;
		
		DECLARE @dw_temp INT = DATEPART(WEEKDAY , @current_date);
		IF @dw_temp = 2 OR @dw_temp = 4 OR @dw_temp = 6
		BEGIN
			INSERT INTO @Shedule(discipline, [group] , teacher , [date] , [time] , spent)
			SELECT 
				discipline	= @discipline_id ,
				[group]		= @group,
				teacher		= @teacher,
				[date]		= @current_date,
				[time]		= '18:30:00',
				spent		= @spent
			FROM Disciplines
			WHERE discipline_id = @discipline_id 

			SET @number_of_leassons -= 1
		END

		SET @current_date = DATEADD(DAY , 1 , @current_date)
	END

	SET @discipline_id += 1;
END

SELECT * FROM @Shedule