--SQLQuery3-isHappyDay.sql
USE PV_522_Import;
GO

CREATE OR ALTER FUNCTION isHappyDay(@date AS DATE = N'0000-00-00') RETURNS BIT
AS 
BEGIN
		DECLARE @year_now	 VARCHAR(9) = CAST(DATEPART(YEAR , @date) AS VARCHAR(9));
		RETURN IIF(NOT (
					@date	= 	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'12',N'30') AS DATE)	OR -- фикс прикола дня в году
					@date	=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'12',N'31') AS DATE)  OR
					@date	>=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'01',N'01') AS DATE)  AND
					@date	<	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'01',N'12') AS DATE)
					)-- Зимние каникулы
					AND 

					NOT(
					@date	>=	CAST(FORMATMESSAGE(N'%s-%s-%s', @year_now , N'07',N'01') AS DATE)	AND
					@date	<=	CAST(FORMATMESSAGE(N'%s-%s-%s', @year_now , N'07',N'21') AS DATE)	
					) -- Летние каникулы
					AND
					256		!=	DATEPART(DAYOFYEAR , @date) 										AND -- День программиста обычно 13 сентября
					
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'01',N'04') AS DATE)	AND --  День народного единства
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'02',N'23') AS DATE)	AND --  День защитника отечества
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'03',N'08') AS DATE)	AND --  Международный женский день
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'05',N'01') AS DATE)	AND --  Праздник весны и труда
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'05',N'09') AS DATE)	AND --  День победы
					@date	!=	CAST(FORMATMESSAGE(N'%s-%s-%s' , @year_now , N'06',N'12') AS DATE)		--  День России
					
					, 1 , 0)		
		    
					
END