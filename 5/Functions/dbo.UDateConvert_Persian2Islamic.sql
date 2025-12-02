SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =========================================================
-- Author:		S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date: 2010/08/14
-- =========================================================

create FUNCTION [dbo].[UDateConvert_Persian2Islamic](@Date VARCHAR(10), @SEPARATOR AS CHAR(1) = '/') RETURNS CHAR(10)
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
		-- persian_islamic
		DECLARE @jdn INT
		DECLARE @ISO_8601 AS TINYINT
		DECLARE @Gregorian AS TINYINT
		
		SET @ISO_8601 = 1
		SET @Gregorian = @ISO_8601
		SET @jdn = dbo.persian_jdn(@IYear,@IMonth,@IDay)
		
		-- jdn_islamic
		DECLARE @mjd As FLOAT(53)
		DECLARE @k As INT
		DECLARE @hm As INT

		-- jdn_civil
		DECLARE @L AS INT
		DECLARE @n AS INT

		IF (@jdn > 2299160)
		BEGIN
			SET @L = @jdn + 68569
			SET @n = dbo.Fix((4 * @L) / CAST(146097 AS REAL))
			SET @L = @L - dbo.Fix((146097 * @n + 3) / CAST(4 AS REAL))
			SET @i = dbo.Fix((4000 * (@L + 1)) / CAST(1461001 AS REAL))
			SET @L = @L - dbo.Fix((1461 * @i) / CAST(4 AS REAL)) + 31
			SET @j = dbo.Fix((80 * @L) / CAST(2447 AS REAL))
			SET @ODay = @L - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @L = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @L
			SET @OYear = 100 * (@n - 49) + @i + @L
		END
		ELSE
		BEGIN
			-- jdn_julian
			SET @j = @jdn + 1402
			SET @k = dbo.Fix((@j - 1) / CAST(1461 AS REAL))
			SET @L = @j - 1461 * @k
			SET @n = dbo.Fix((@L - 1) / CAST(365 AS REAL)) - dbo.Fix(@L / CAST(1461 AS REAL))
			SET @i = @L - 365 * @n + 30
			SET @j = dbo.Fix((80 * @i) / CAST(2447 AS REAL))
			SET @ODay = @i - dbo.Fix((2447 * @j) / CAST(80 AS REAL))
			SET @i = dbo.Fix(@j / CAST(11 AS REAL))
			SET @OMonth = @j + 2 - 12 * @i
			SET @OYear = 4 * @k + @n + @i - 4716
		END
		
		SET @k = FLOOR(0.6 + (@OYear + CAST((@OMonth - 0.5) AS INT) / CAST(12 AS REAL) + @ODay / CAST(365 AS REAL) - 1900) * 12.3685)
	    
		WHILE (1 = 1)
		BEGIN
			SET @mjd = dbo.visibility(@k)
			SET @k = @k - 1
			IF NOT (@mjd > (@jdn - 0.5)) BREAK
		END
	    
		SET @k = @k + 1
		SET @hm = @k - 1048
		SET @OYear = 1405 + dbo.Fix(@hm / CAST(12 AS REAL))
		--@Year = 1405 + Int(@hm / 12)
	    
		SET @OMonth = (@hm % 12) + 1
		IF (@hm <> 0 And @OMonth <= 0)
		BEGIN
			SET @OMonth = @OMonth + 12
			SET @OYear = @OYear - 1
		END
		IF @OYear <= 0
			SET @OYear = @OYear - 1
		
		SET @ODay = FLOOR(@jdn - @mjd + 0.5)
		
		SET @Result =	RIGHT('0000'	+ CAST(@OYear	AS VARCHAR(10)),4) + '/' + 
						RIGHT('0'		+ CAST(@OMonth	AS VARCHAR(10)),2) + '/' + 
						RIGHT('0'		+ CAST(@ODay	AS VARCHAR(10)),2)
	END
	
	RETURN @Result
END
GO
