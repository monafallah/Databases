SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListAghsatVam]
@Year SMALLINT,
@Month TINYINT,
@organId INT,
@CalcType TINYINT=1
as

BEGIN TRAN

SELECT     Pay.tblMohasebat.fldId, Pay.tblMohasebat.fldPersonalId, Pay.tblMohasebat.fldYear, Com.fn_month(Pay.tblMohasebat.fldMonth) AS fldMonth, 
                     tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.tblMohasebat.fldGhestVam,Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName
FROM         Pay.tblMohasebat INNER JOIN
pay.tblMohasebat_PersonalInfo on Pay.tblMohasebat.fldid=pay.tblMohasebat_PersonalInfo.fldMohasebatId inner join
					  pay.Pay_tblPersonalInfo on Pay.tblMohasebat.fldPersonalId = pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId
                      WHERE fldYear=@Year AND fldMonth=@Month AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId AND fldGhestVam<>0
                      and fldCalcType=@CalcType
					  ORDER BY tblEmployee.fldFamily,fldName

ROLLBACK
GO
