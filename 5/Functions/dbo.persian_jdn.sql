SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create FUNCTION [dbo].[persian_jdn](@Year As INT,@Month As INT,@Day As INT) RETURNS INT AS
BEGIN
    DECLARE @PERSIAN_EPOCH INT
    SET @PERSIAN_EPOCH = 1948321 -- The JDN of 1 Farvardin 1

    DECLARE @epbase AS INT
    DECLARE @epyear AS INT
    DECLARE @mdays AS INT
    DECLARE @Result AS INT
    
    IF @Year >= 0
        SET @epbase = @Year - 474
    ELSE
        SET @epbase = @Year - 473
    
    SET @epyear = 474 + (@epbase % 2820)
    
    IF @Month <= 7
        SET @mdays = (@Month - 1) * 31
    ELSE
        SET @mdays = (@Month - 1) * 30 + 6
    
    SET @Result =
		  @Day
		+ @mdays
		+ dbo.Fix(((@epyear * 682) - 110) / CAST(2816 AS REAL))
		+ (@epyear - 1) * 365
		+ dbo.Fix(@epbase / CAST(2820 AS REAL)) * 1029983
		+ (@PERSIAN_EPOCH - 1)
		
	RETURN @Result
END

GO
