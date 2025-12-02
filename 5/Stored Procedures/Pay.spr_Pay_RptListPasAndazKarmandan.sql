SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPasAndazKarmandan](@Year SMALLINT,@month TINYINT,@NobatPardakht TINYINT,@organId INT)
as

SELECT     tblEmployee.fldName+'_'+tblEmployee.fldFamily AS fldName_Family, Prs.Prs_tblPersonalInfo.fldSh_Personali, fldSh_Shenasname, 
                      fldFatherName, (Pay.tblMohasebat.fldPasAndaz+ISNULL((SELECT SUM(tblMoavaghat.fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) )/ 2 AS fldSahmPasandaz, Pay.tblMohasebat.fldPasAndaz+ISNULL((SELECT SUM(tblMoavaghat.fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS fldPasAndaz,
                      fldShPasAndazPersonal,fldShPasAndazKarFarma,fldKarkard
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear=@Year AND fldMonth=@month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
						AND tblMohasebat.fldPasAndaz<>0 and fldCalcType=1
						ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
GO
