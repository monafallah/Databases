SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Pay].[spr_PaySooratHesabKosuratParametri](@IdKosurat INT,@IdPersonal INT,@organId INT,@CalcType TINYINT=1)
AS
IF(@IdKosurat<>0)
SELECT    Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, 
                      CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle, 
                      Pay.[tblMohasebat_kosorat/MotalebatParam].fldMablagh AS MablaghMohasebat, Pay.tblMohasebat.fldYear, Pay.tblMohasebat.fldMonth
					 ,[com].[fun_MandeOrJamKosurat] (tblKosorateParametri_Personal.fldId) AS MandeOrJam
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblKosorateParametri_Personal.fldId = Pay.[tblMohasebat_kosorat/MotalebatParam].fldKosoratId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat.fldId = Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId        
	WHERE Pay.tblKosorateParametri_Personal.fldId = @IdKosurat AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId 
    and fldCalcType=1

IF(@IdPersonal<>0)
SELECT    Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, 
                      CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle, 
                      Pay.[tblMohasebat_kosorat/MotalebatParam].fldMablagh AS MablaghMohasebat, Pay.tblMohasebat.fldYear, Pay.tblMohasebat.fldMonth
					 ,[com].[fun_MandeOrJamKosurat] (tblKosorateParametri_Personal.fldId) AS MandeOrJam
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.[tblMohasebat_kosorat/MotalebatParam] ON Pay.tblKosorateParametri_Personal.fldId = Pay.[tblMohasebat_kosorat/MotalebatParam].fldKosoratId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat.fldId = Pay.[tblMohasebat_kosorat/MotalebatParam].fldMohasebatId        
	WHERE  Pay.tblKosorateParametri_Personal.fldPersonalId = @IdPersonal AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId 
    and fldCalcType=1

GO
