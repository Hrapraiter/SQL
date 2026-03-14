--SQLQuery1-SelectSchedule.sql

USE PV_522_Import;
GO
-- sp - StoredProcedure
CREATE PROCEDURE sp_SelectSchedule 
AS 
BEGIN
	
	SELECT
			[Группа]		=	group_name,
			[Дисциплина]	=	discipline_name,
			[Преподаватель]	=	FORMATMESSAGE(N'%s %s %s' , last_name , first_name , middle_name),
			[Дата]			=	[date],
			[День недели]	=	DATENAME(WEEKDAY , [date]),
			[Время]			=	[time],
			[Статус]		=	IIF(spent=1 , N'Проведенно' , N'Запланированно')
	FROM Schedule , Groups , Disciplines , Teachers
	WHERE	[group]			=	group_id
	AND		discipline		=	discipline_id
	AND		teacher			=	teacher_id
	ORDER BY [date]
END