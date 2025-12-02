SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_IsBimeForMotalebate](@IdMotalebat INT)
RETURNS BIT
AS
BEGIN
DECLARE @Type BIT,@id INT
SELECT   @type=  fldMashmoleBime
FROM         Pay.tblMotalebateParametri_Personal
WHERE fldId=@id
RETURN @Type
END
GO
