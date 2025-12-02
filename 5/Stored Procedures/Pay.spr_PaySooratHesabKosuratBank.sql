SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_PaySooratHesabKosuratBank](@IdKosurat INT,@IdPersonal INT,@organid int)
as
IF(@IdKosurat<>0)
SELECT    Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName, 
                      Pay.tblKosuratBank.fldMandeAzGhabl, Pay.tblKosuratBank.fldMandeDarFish, tblEmployee.fldName, tblEmployee.fldFamily, Pay.tblMohasebat.fldYear, 
                      Pay.tblMohasebat.fldMonth, Pay.tblMohasebat_KosoratBank.fldMablagh AS MablaghMohasebe,
                       [Com].[fun_MandeKosuratBank] (Pay.tblKosuratBank.fldId) AS MandeDaFish
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Pay.tblMohasebat_KosoratBank ON Pay.tblKosuratBank.fldId = Pay.tblMohasebat_KosoratBank.fldKosoratBankId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId
                      	WHERE  Pay.tblKosuratBank.fldId = @IdKosurat AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                      	
IF(@IdPersonal<>0)
SELECT    Pay.tblKosuratBank.fldId, Pay.tblKosuratBank.fldPersonalId, Pay.tblKosuratBank.fldShobeId, Pay.tblKosuratBank.fldMablagh, Pay.tblKosuratBank.fldCount, 
                      Pay.tblKosuratBank.fldTarikhPardakht, Pay.tblKosuratBank.fldShomareHesab, Pay.tblKosuratBank.fldStatus, Pay.tblKosuratBank.fldDeactiveDate, 
                      Pay.tblKosuratBank.fldUserID, Pay.tblKosuratBank.fldDesc, Pay.tblKosuratBank.fldDate, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, tblSHobe.fldName AS ShobeName, 
                      CASE WHEN (Pay.tblKosuratBank.fldStatus = 0) THEN N'غیر فعال' ELSE N'فعال' END AS fldStatusName, Com.tblBank.fldBankName, 
                      Pay.tblKosuratBank.fldMandeAzGhabl, Pay.tblKosuratBank.fldMandeDarFish, tblEmployee.fldName, tblEmployee.fldFamily, Pay.tblMohasebat.fldYear, 
                      Pay.tblMohasebat.fldMonth, Pay.tblMohasebat_KosoratBank.fldMablagh AS MablaghMohasebe,
                       [Com].[fun_MandeKosuratBank] (Pay.tblKosuratBank.fldId) AS MandeDaFish
FROM         Pay.tblKosuratBank INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosuratBank.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId INNER JOIN
                      Com.tblBank ON tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Pay.tblMohasebat_KosoratBank ON Pay.tblKosuratBank.fldId = Pay.tblMohasebat_KosoratBank.fldKosoratBankId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_KosoratBank.fldMohasebatId = Pay.tblMohasebat.fldId
                      	WHERE  Pay.tblKosuratBank.fldPersonalId = @IdPersonal AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId                      	
                      	
GO
