--SQLQuery1-GetNextLearningDay.sql - возвращает следующий день недели  в который должно пройти следующее занятие
USE PV_522_Import;
GO

ALTER FUNCTION GetNextLearningDay (@group_name AS NCHAR(10) , @last_learning_date AS DATE)RETURNS TINYINT
AS
BEGIN
		DECLARE @group_id			AS INT		= (SELECT group_id FROM Groups WHERE group_name = @group_name);
		DECLARE @learning_days		AS TINYINT  = (SELECT learning_days FROM Groups WHERE group_id=@group_id);
		DECLARE @last_learning_day	AS TINYINT	= DATEPART(WEEKDAY, @last_learning_date);
		DECLARE @next_learning_day	AS TINYINT	= 0;
		DECLARE @day				AS TINYINT	= @last_learning_day + 1;
		
		WHILE @day < 14
		BEGIN
				IF @learning_days & POWER(2 , @day%7-1) <> 0	--POWER(основание_степени, показатель_степени). <> - НЕ равно
					RETURN @day%7;
					
				SET @day += 1;
		END

		RETURN 0;
END