SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_AshkhasIdwithPersonalId](@Id INT)
RETURNS INT
AS
BEGIN
	DECLARE @IdAshkhas INT
	SELECT     @IdAshkhas=tblAshkhas.fldId
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblAshkhas ON Com.tblEmployee.fldId = Com.tblAshkhas.fldHaghighiId
                      WHERE Pay_tblPersonalInfo.fldId=@Id
 RETURN @IdAshkhas                     
END
GO
