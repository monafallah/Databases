SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[fn_IsKabise](@year SMALLINT)
RETURNS BIT
as
BEGIN 
DECLARE @result TINYINT=0,@Kabise bit

SET @result=(@year%33)
IF (@result IN (1,5,9,13,18,22,26,30))
	SET @Kabise=1
ELSE
	SET @Kabise=0
	 
RETURN @Kabise
end

GO
