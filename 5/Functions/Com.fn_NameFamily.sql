SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_NameFamily](@Pay_PersonalInfoId INT)
RETURNS NVARCHAR(150)
AS
BEGIN
DECLARE @name NVARCHAR(150)=''
SELECT @name=tblEmployee.fldFamily+'_'+tblEmployee.fldName+'('+ fldFatherName+')' FROM Pay.Pay_tblPersonalInfo 
INNER JOIN Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId=Prs_tblPersonalInfo.fldId
INNER JOIN Com.tblEmployee AS tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
WHERE Pay.Pay_tblPersonalInfo.fldid=@Pay_PersonalInfoId
ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
RETURN @name
END
GO
