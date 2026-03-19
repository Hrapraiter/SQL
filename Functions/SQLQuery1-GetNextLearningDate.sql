--SQLQuery1-GetNextLearningDate.sql

USE PV_522_Import;
GO

CREATE FUNCTION GetNextLearningDate(@group_name AS NCHAR(10), @last_learning_date AS DATE = N'1900-01-01')RETURNS DATE
AS
BEGIN
		DECLARE @group AS INT = (SELECT group_id FROM Groups WHERE group_name = @group_name);
		

END