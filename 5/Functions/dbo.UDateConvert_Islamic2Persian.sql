SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================
create FUNCTION [dbo].[UDateConvert_Islamic2Persian](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = '/') RETURNS CHAR(10)
AS
BEGIN
	DECLARE @Result CHAR(10)
	DECLARE @IYear INT 
	DECLARE @IMonth INT 
	DECLARE @IDay INT 
	DECLARE @OYear INT 
	DECLARE @OMonth INT 
	DECLARE @ODay INT 
	
	-- read date
	DECLARE @temp VARCHAR(10)
	DECLARE @i INT
	DECLARE @j INT
	
	SET @i = CHARINDEX(@SEPARATOR, @Date)
	IF @i > 1
	BEGIN
		SET @temp = LEFT(@Date, @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IYear = CAST(@temp AS INT)
		ELSE
			SET @IYear = 0
	END
	ELSE
		SET @IYear = 0
		
	SET @j = CHARINDEX(@SEPARATOR, @Date, @i + 1)
	IF @j > 0
	BEGIN
		SET @temp = SUBSTRING(@Date,@i + 1,@j - @i - 1)
		IF ISNUMERIC(@temp) = 1
			SET @IMonth = CAST(@temp AS INT)
		ELSE
			SET @IMonth = 0
		
		IF @j < LEN(@Date)
		BEGIN
			SET @temp = RIGHT(@Date,LEN(@Date) - @j)
			IF ISNUMERIC(@temp) = 1
				SET @IDay = CAST(@temp AS INT)
			ELSE
				SET @IDay = 0
		END
		ELSE
			SET @IDay = 0
		
		IF @IMonth <= 0 SET @IMonth = 1
		IF @IMonth > 12 SET @IMonth = 12
		
		IF @IDay <= 0 SET @IDay = 1
		IF @IDay > 31 SET @IDay = 31
	END
	ELSE
	BEGIN
		SET @IMonth = 0
		SET @IDay = 0
	END
	
	IF @IYear = 0 AND @IMonth = 0 AND @IDay = 0 
		SET @Result = NULL
	ELSE
	BEGIN
		-- islamic_persian
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.islamic_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_persian
		DECLARE @depoch AS INT
		DECLARE @cycle AS INT
		DECLARE @cyear AS INT
		DECLARE @ycycle AS INT
		DECLARE @aux1 AS INT
		DECLARE @aux2 AS INT
		DECLARE @yday AS INT
	    
		SET @depoch = @jdn - dbo.persian_jdn(475, 1, 1)
		SET @cycle = dbo.Fix(@depoch / CAST(1029983 AS REAL))
		SET @cyear = @depoch % 1029983
		IF @cyear = 1029982
			SET @ycycle = 2820
		ELSE
		BEGIN
			SET @aux1 = dbo.Fix(@cyear / CAST(366 AS REAL))
			SET @aux2 = @cyear % 366
			SET @ycycle = FLOOR(((2134 * @aux1) + (2816 * @aux2) + 2815) / CAST(1028522 AS REAL)) + @aux1 + 1
		END
	    
		SET @OYear = @ycycle + (2820 * @cycle) + 474
		IF @OYear <= 0 
			SET @OYear = @OYear - 1
	    
		SET @yday = (@jdn - dbo.persian_jdn(@OYear, 1, 1)) + 1
		IF @yday <= 186 
			SET @OMonth = dbo.Ceil(@yday / CAST(31 AS REAL))
		ELSE
			SET @OMonth = dbo.Ceil((@yday - 6) / CAST(30 AS REAL))
	    
		SET @ODay = (@jdn - dbo.persian_jdn(@OYear, @OMonth, 1)) + 1
		
		SET @Result =	RIGHT('0000'	+ CAST(@OYear	AS VARCHAR(10)),4) + '/' + 
						RIGHT('0'		+ CAST(@OMonth	AS VARCHAR(10)),2) + '/' + 
						RIGHT('0'		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
GO
