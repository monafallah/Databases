SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_NoEstekhdam](@fldAnvaEstekhdamId INT)
RETURNS INT
AS 
BEGIN
DECLARE @NoeEstekhdam int

SELECT   @NoeEstekhdam=  fldNoeEstekhdamId
FROM         Com.tblAnvaEstekhdam WHERE fldid=@fldAnvaEstekhdamId
RETURN @NoeEstekhdam
END
GO
