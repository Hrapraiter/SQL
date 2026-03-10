--SQLQuery4-COUNT.sql

USE PV_522_Import;

--SELECT 
--		direction_name AS  N'Направление обучения',
--		COUNT(group_id) AS N'Колличество групп'
--FROM Groups , Directions
--WHERE direction = direction_id
--GROUP BY direction_name
--;

--SELECT 
--			group_name		AS N'Имя группы',
--			COUNT(stud_id)	AS N'Колличество студентов'

--FROM		Students , Groups 
--WHERE		[group] = group_id
--GROUP BY	group_name 
--HAVING	COUNT(stud_id) > 10;

--SELECT 
--		[Направление обучения]	=	direction_name,
--		[Колличество групп]		=	COUNT(DISTINCT group_id),
--		[Колличество студентов] =	COUNT(stud_id)

--FROM Students , Groups , Directions
--WHERE	[group] = group_id
--AND		direction = direction_id
--GROUP BY direction_name

--SELECT 
--		[Направление обучения]	= direction_name,
--		[Колличество групп]		= (SELECT COUNT(group_id) FROM Groups WHERE direction = direction_id)
--FROM Directions


