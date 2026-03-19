--SQLQuery1-GetLastLearningDay.sql

USE PV_522_Import;
GO

ALTER FUNCTION GetLastLearningDate(@group_name NCHAR(10)) RETURNS DATE
AS
BEGIN
	RETURN	(SELECT MAX([date]) FROM Schedule WHERE [group] = (SELECT group_id FROM Groups WHERE group_name = @group_name) );
	--DECLARE @group_id	AS INT = (SELECT group_id FROM Groups WHERE group_name = @group_name) 
	--MAX() - это функция агрегирования
	--К функциям агрегирования относятся COUNT() , SUM() , AVG() , MIN() , MAX();
END