SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_PersonalIdwithAshkhasId] (@AshkhasId INT)
RETURNS INT
AS
BEGIN
DECLARE @id INT
SELECT    @id=  Pay.Pay_tblPersonalInfo.fldId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblEmployee.fldId = Com.tblAshkhas.fldHaghighiId
                      WHERE tblAshkhas.fldId=@AshkhasId
RETURN @id
end
                      
GO
