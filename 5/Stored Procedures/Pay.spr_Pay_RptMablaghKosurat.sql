SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptMablaghKosurat](@IdKosurat INT,@CalcType TINYINT=1)
as
SELECT        Pay.tblMohasebat.fldYear, Pay.tblMohasebat.fldMonth, Pay.[tblMohasebat_kosorat/MotalebatParam].fldMablagh, Pay.tblKosorateParametri_Personal.fldMondeGHabl, 
                         Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl,Com.tblEmployee.fldFamily+'_'+ Com.tblEmployee.fldName+'('+ Com.tblEmployee_Detail.fldFatherName+')' AS fldName_Family, Prs.Prs_tblPersonalInfo.fldSh_Personali
FROM            Pay.[tblMohasebat_kosorat/MotalebatParam] INNER JOIN
                         Pay.tblMohasebat ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                         Pay.tblKosorateParametri_Personal ON Pay.[tblMohasebat_kosorat/MotalebatParam].fldKosoratId = Pay.tblKosorateParametri_Personal.fldId INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId						 
						 WHERE fldKosoratId=@IdKosurat AND fldKosoratId IS NOT NULL and fldCalcType=@CalcType
GO
