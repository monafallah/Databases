SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- ====================================================================
-- Source Program		: http://www.vojoudi.com/vb/index.htm
-- Source Technology	: VB 6.0 
-- By					: Mehdi Vojoudi (info@vojoudi.com)
-- Converted to T-SQL by: S.Mansoor Omrani (mansoor.omrani@gmail.com)
-- Create date			: 2010/08/14
-- Description			:
--
-- Given a Hijri date, compute corresponding julian day number
--
create FUNCTION [dbo].[islamic_jdn](@Year As INT,@Month As INT,@Day As INT) RETURNS INT
AS
BEGIN
    -- NMONTH is the number of months between julian day number 1 and
    -- the @Year 1405 A.H. which started immediatly after lunar
    -- conjunction number 1048 which occured on September 1984 25d
    -- 3h 10m UT.
    DECLARE @Result INT
    DECLARE @NMONTHS INT
    SET @NMONTHS = (1405 * 12 + 1)

    DECLARE @k AS INT
    
    IF (@Year < 0) SET @Year = @Year + 1
    SET @k = @Month + @Year * 12 - @NMONTHS -- nunber of months since 1/1/1405
    SET @Result = FLOOR(dbo.visibility(@k + CAST(1048 AS INT)) + @Day + 0.5)
    
    RETURN @Result
END
GO
