--SQLQuery4-HW.sql

USE PV_522_Import;

-- 1)

--SELECT * FROM Disciplines;


-- 2)

--SELECT 
--	[Teacher] = FORMATMESSAGE('%s %s %s', last_name , first_name , middle_name),
--	discipline_name
--FROM Teachers , Disciplines , TeachersDisciplinesRelation
--WHERE teacher = teacher_id AND discipline_id = discipline

-- 3)

--SELECT 
--	discipline_name,
--	[Teacher] = FORMATMESSAGE('%s %s %s' , last_name , first_name , middle_name)
--FROM Disciplines , Teachers , TeachersDisciplinesRelation
--WHERE teacher_id = teacher AND discipline_id = discipline
--;

-- 4)

--SELECT 
--	[Teacher]			= FORMATMESSAGE('%s %s %s' , last_name , first_name , middle_name),
--	[discipline_count]	= (SELECT COUNT(*) FROM TeachersDisciplinesRelation WHERE teacher = teacher_id)

--FROM Teachers , TeachersDisciplinesRelation
--WHERE teacher = teacher_id
--GROUP BY teacher_id , teacher , last_name , first_name , middle_name HAVING COUNT(*) > 1;

-- 5)

--SELECT 
--	discipline_name,
--	[teachers_count] = (SELECT COUNT(*) FROM TeachersDisciplinesRelation WHERE discipline = discipline_id)
--FROM Disciplines , TeachersDisciplinesRelation
--WHERE discipline = discipline_id
--GROUP BY discipline_id , discipline_name , discipline HAVING COUNT(*) > 1



--SELECT COUNT(*) FROM TABLE колличество стобцов в таблице

--GROUP BY Name , Department групировать по полям name , department
--HAVING COUNT(*) > 1 фильтровать по колличеству строк больше 1

--DECLARE @name TYPE; выделение переменной
--SET @name = N'Павел' задать значение