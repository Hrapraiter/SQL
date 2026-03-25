--SQLQuery7-GetEasterDate.sql
USE PV_522_Import;
SET DATEFIRST 1;
GO

CREATE OR ALTER FUNCTION GetEasterDate(@year AS SMALLINT) RETURNS DATE
AS
BEGIN

	 --DECLARE @a AS TINYINT = @year % 19;
	 --DECLARE @b AS TINYINT = @year / 100;
	 --DECLARE @c AS TINYINT = @year % 100;
	 --DECLARE @d AS TINYINT = @b / 4;
	 --DECLARE @e AS TINYINT = @b % 4;
	 --DECLARE @f AS TINYINT = (@b + 8) / 25;
	 --DECLARE @g AS TINYINT = (@b - @f + 1) / 3;
	 --DECLARE @h AS TINYINT = (19 * @a + @b - @d - @g + 15 ) % 30;
	 --DECLARE @i AS TINYINT = @c /4;
	 --DECLARE @k AS TINYINT = @c %4;
	 --DECLARE @l AS TINYINT = (32 + 2*@e + 2*@i - @h - @k) % 7;
	 --DECLARE @m AS TINYINT = (@a + 11 * @h + 22 * @l) / 451;
	 
	 --DECLARE @mounth AS TINYINT = (@h + @l - 7*@m +114)/31;
	 --DECLARE @day	 AS TINYINT	= (@h + @l - 7*@m +114)%31 + 1; -- Католическая
	 
	 --RETURN DATEFROMPARTS(@year , @mounth , @day);
	 
	 DECLARE @a AS TINYINT = @year % 19;
	 DECLARE @b AS TINYINT = @year % 4;
	 DECLARE @c AS TINYINT = @year % 7;
	 DECLARE @d AS TINYINT = (19*@a + 15) % 30;
	 DECLARE @e AS TINYINT = (2*@b + 4*@c + 6*@d + 6) % 7;
	 DECLARE @f AS TINYINT = @d + @e;

	 DECLARE @mounth AS TINYINT = IIF(@f <= 9 , 03 , 04);
	 DECLARE @day    AS TINYINT = IIF(@f <= 9 , 22 + @f , @f - 9); --Православная

	 RETURN DATEADD(DAY , IIF(@year < 2100 , 13 , 14) ,DATEFROMPARTS(@year , @mounth , @day));
END