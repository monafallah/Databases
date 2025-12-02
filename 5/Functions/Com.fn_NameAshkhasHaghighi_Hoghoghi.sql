SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_NameAshkhasHaghighi_Hoghoghi](@AshkhasId INT)
RETURNS NVARCHAR(300)
AS BEGIN
DECLARE @haghighiId INT ,@hoghoghiId INT,@name NVARCHAR(300)
SELECT @haghighiId=fldHaghighiId,@hoghoghiId=fldHoghoghiId FROM Com.tblAshkhas WHERE fldid=@AshkhasId
IF(@haghighiId IS NOT NULL )
SELECT     @name=fldName+' '+ fldFamily
FROM         Com.tblEmployee
WHERE fldId=@haghighiId
ELSE IF (@hoghoghiId IS NOT NULL)
SELECT     @name=fldName 
FROM         Com.tblAshkhaseHoghoghi
WHERE fldId=@hoghoghiId
RETURN @name
end

GO
