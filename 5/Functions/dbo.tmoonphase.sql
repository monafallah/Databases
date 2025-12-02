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
create FUNCTION [dbo].[tmoonphase](@n AS INT,@nph AS INT) RETURNS FLOAT(53)
AS
BEGIN
	DECLARE @RPD FLOAT(53)
	DECLARE @Result FLOAT(53)
    SET @RPD = (1.74532925199433E-02) -- radians per degree (pi/180)

    DECLARE @jd AS FLOAT(53)
    DECLARE @t AS FLOAT(53)
    DECLARE @t2 AS FLOAT(53)
    DECLARE @t3 AS FLOAT(53)
    DECLARE @k AS FLOAT(53)
    DECLARE @ma AS FLOAT(53)
    DECLARE @sa AS FLOAT(53)
    DECLARE @tf AS FLOAT(53)
    DECLARE @xtra AS FLOAT(53)

    SET @k = @n + @nph / CAST(4 AS FLOAT(53))
    SET @t = @k / CAST(1236.85 AS FLOAT(53))
    SET @t2 = @t * @t
    SET @t3 = @t2 * @t
    SET @jd = 2415020.75933 + 29.53058868 * @k - 0.0001178 * @t2
        - 0.000000155 * @t3 
        + 0.00033 * SIN(@RPD * (166.56 + 132.87 * @t - 0.009173 * @t2))
--
--   Sun--s mean anomaly
    SET @sa = @RPD * (359.2242 + 29.10535608 * @k - 0.0000333 * @t2 - 0.00000347 * @t3)
--
--   Moon--s mean anomaly
    SET @ma = @RPD * (306.0253 + 385.81691806 * @k + 0.0107306 * @t2 + 0.00001236 * @t3)
    
--
--   Moon--s argument of latitude
    SET @tf = @RPD * CAST(2 AS FLOAT(53)) * (21.2964 + 390.67050646 * @k - 0.0016528 * @t2 
              - 0.00000239 * @t3)
--
--   should reduce to interval 0-1.0 before calculating further
    IF @nph IN (0,2)
        SET @xtra = (0.1734 - 0.000393 * @t) * SIN(@sa) 
              + 0.0021 * SIN(@sa * 2) 
              - 0.4068 * SIN(@ma) + 0.0161 * SIN(2 * @ma) - 0.0004 * SIN(3 * @ma) 
              + 0.0104 * SIN(@tf) 
              - 0.0051 * SIN(@sa + @ma) - 0.0074 * SIN(@sa - @ma) 
              + 0.0004 * SIN(@tf + @sa) - 0.0004 * SIN(@tf - @sa) 
              - 0.0006 * SIN(@tf + @ma) + 0.001 * SIN(@tf - @ma) 
              + 0.0005 * SIN(@sa + 2 * @ma)
	ELSE
	IF @nph IN(1, 3)
	BEGIN
        SET @xtra = (0.1721 - 0.0004 * @t) * SIN(@sa) 
              + 0.0021 * SIN(@sa * 2) 
              - 0.628 * SIN(@ma) + 0.0089 * SIN(2 * @ma) - 0.0004 * SIN(3 * @ma) 
              + 0.0079 * SIN(@tf) 
              - 0.0119 * SIN(@sa + @ma) - 0.0047 * SIN(@sa - @ma) 
              + 0.0003 * SIN(@tf + @sa) - 0.0004 * SIN(@tf - @sa) 
              - 0.0006 * SIN(@tf + @ma) + 0.0021 * SIN(@tf - @ma) 
              + 0.0003 * SIN(@sa + 2 * @ma) + 0.0004 * SIN(@sa - 2 * @ma) 
              - 0.0003 * SIN(2 * @sa + @ma)
        IF (@nph = 1)
            SET @xtra = @xtra + 0.0028 - 0.0004 * COS(@sa) + 0.0003 * COS(@ma)
        ELSE
            SET @xtra = @xtra - 0.0028 + 0.0004 * COS(@sa) - 0.0003 * COS(@ma)
    END
    ELSE
    BEGIN
        SET @Result = 0
        RETURN @Result
    END
--   convert from Ephemeris Time (ET) to (approximate)Universal Time (UT)
    SET @Result = @jd + @xtra - (0.41 + 1.2053 * @t + 0.4992 * @t2) / CAST(1440 AS FLOAT(53))
    
    RETURN @Result
END
GO
