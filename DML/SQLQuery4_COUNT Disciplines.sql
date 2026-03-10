--SQLQuery4_COUNT Disciplines.sql

USE PV_522_Import;


SELECT 
		--[Дисциплина]	= discipline_name
		FORMATMESSAGE(N'%s %s %s' , last_name , first_name , middle_name)
FROM Disciplines , TeachersDisciplinesRelation , Teachers
WHERE	discipline_id	= discipline
AND		teacher_id		= teacher
--AND		last_name		= N'Глазунов'
AND		discipline_name LIKE N'%MS SQL%'
;