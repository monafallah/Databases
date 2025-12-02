SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[familyEmployee](@EmployeeId int)
RETURNS nvarchar(max)
AS
BEGIN
declare @Name_Father nvarchar(max)

SELECT     @Name_Father=fldFamily+'_'+fldName+' '+'('+ fldFatherName+')'
FROM         Com.tblEmployee INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
			
WHERE Com.tblEmployee.fldId=@EmployeeId

return @Name_Father
END
GO
