SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListAghsatVam_Excel]
@Year SMALLINT,
@Month TINYINT,
@organId INT,
@CalcType TINYINT=1
as

BEGIN TRAN

SELECT         '"";"' + CAST(Pay.tblMohasebat.fldGhestVam AS nvarchar(10)) + '";"'+ Com.tblEmployee.fldCodemeli+'";"' +Com.tblEmployee.fldName+' ' +Com.tblEmployee.fldFamily+'";"1"' as fldName
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId AND Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId AND 
                         Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId AND Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId AND Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId AND 
                         Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId AND Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId
WHERE        (Pay.tblMohasebat.fldYear = @Year) AND (Pay.tblMohasebat.fldMonth = @Month) AND (Pay.tblMohasebat_PersonalInfo.fldOrganId = @organId)and fldGhestVam<>0
and fldCalcType=@CalcType
ORDER BY tblEmployee.fldFamily,fldName

commit tran
GO
