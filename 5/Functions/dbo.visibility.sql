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
-- ====================================================================
create FUNCTION [dbo].[visibility](@n AS INT) RETURNS FLOAT(53)
AS
BEGIN
    -- parameters for Makkah: for a new moon to be visible after @SUNSET on
    -- a the same day in which it started, it has to have started before
    -- (@SUNSET-@MINAGE)-@TIMZ=3 A.M. local time.
    DECLARE @Result FLOAT(53)
    
    DECLARE @TIMZ AS FLOAT
    DECLARE @MINAGE AS FLOAT
    DECLARE @SUNSET AS FLOAT
    DECLARE @TIMDIF AS FLOAT
    
    SET @TIMZ = 3.0
    SET @MINAGE = 13.5
    SET @SUNSET = 19.5 -- approximate
    SET @TIMDIF = (@SUNSET - @MINAGE)

    DECLARE @jd AS FLOAT(53)
    DECLARE @tf AS FLOAT
    DECLARE @d AS INT
    
    SET @jd = dbo.tmoonphase(@n, 0)
    SET @d = FLOOR(@jd)
    SET @tf = (@jd - @d)
    IF (@tf <= 0.5)   -- new moon starts in the afternoon
        SET @Result = (@jd + CAST(1 AS FLOAT(53)))
    ELSE  -- new moon starts before noon
    BEGIN
        SET @tf = (@tf - 0.5) * 24 + @TIMZ -- local time
        IF (@tf > @TIMDIF) 
            SET @Result = (@jd + CAST(1 AS FLOAT(53))) -- age at @SUNSET < min for visiblity
        ELSE
            SET @Result = (@jd)
    END
    
    RETURN @Result
END
GO
