SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptTasvirShakh](@IdPersonal INT,@organId INT)
AS
BEGIN
declare  @photo varbinary(max) = null
	IF(@IdPersonal<>0)
SELECT     Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, tblFile.fldImage
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId inner join
					  pay.Pay_tblPersonalInfo as p on p.fldPrs_PersonalInfoId=Prs_tblPersonalInfo.fldId
WHERE /*Prs.Prs_tblPersonalInfo.fldId*/p.fldId=@IdPersonal AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@organId
ELSE
SELECT Prs.Prs_tblPersonalInfo.fldId,Prs.Prs_tblPersonalInfo.fldEmployeeId, @photo as fldImage--tblFile.fldImage
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
WHERE Prs.Prs_tblPersonalInfo.fldId IN (SELECT fldPrs_PersonalInfoId FROM Pay.Pay_tblPersonalInfo WHERE fldid IN (SELECT fldPersonalId FROM Pay.tblMohasebat))AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@organId
END

GO
