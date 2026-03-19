--SQLQuery1-GetNextLearningDay.sql - возвращает следующий день недели  в который должно пройти следующее занятие
USE PV_522_Import;
GO

CREATE FUNCTION GetNextLearningDay (@group_name AS NCHAR(10) , @last_learning_date AS DATE)RETURNS TINYINT
AS
BEGIN
		DECLARE @group_id			AS INT		= (SELECT group_id FROM Groups WHERE group_name = @group_name);
		DECLARE @last_learning_day	AS TINYINT	= DATEPART(WEEKDAY, @last_learning_date);

END