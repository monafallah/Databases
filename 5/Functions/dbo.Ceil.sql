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
create FUNCTION [dbo].[Ceil](@x FLOAT(53))
RETURNS BIGINT
AS
BEGIN
	DECLARE @Result BIGINT

	IF @x >= 0
		SET @Result = CEILING(@x)
	ELSE
		SET @Result = FLOOR(@x)
	
	RETURN @Result
END
GO
