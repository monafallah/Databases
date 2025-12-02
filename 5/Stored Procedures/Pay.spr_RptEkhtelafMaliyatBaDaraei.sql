SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc  [Pay].[spr_RptEkhtelafMaliyatBaDaraei](@Year SMALLINT,@Month TINYINT ,@NobatPardakht TINYINT,@organId INT)
as
begin tran

select   fldPersonalId,  fldName, fldFatherName,fldCodemeli, fldMaliyat,fldMaliyatMoavagh,fldMaliyatCalc,fldMaliyat+fldMaliyatMoavagh-fldMaliyatCalc as fldEkhtelafMaliyat
 from( 
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, 
                     fldCodemeli,sum(fldMaliyat) as fldMaliyat,sum(isnull(fldMaliyatCalc, 0))fldMaliyatCalc
					  ,sum(isnull(m.fldMaliyatMoavagh, 0)) AS fldMaliyatMoavagh
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN					  
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
					  outer apply (SELECT     SUM(tblMoavaghat.fldMaliyat) AS fldMaliyatMoavagh
                              FROM         Pay.tblMoavaghat
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId))m					
					 WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth<=@Month 
					 --AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht                  
					 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID and fldCalcType=1
					 group by Pay.Pay_tblPersonalInfo.fldId , tblEmployee.fldName, tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, fldCodemeli
                     )t
commit tran
                      
GO
