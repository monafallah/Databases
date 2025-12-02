SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_DisketBime_Tatilkar_Ezafekar](@fieldName NVARCHAR(50),@sal SMALLINT,@mah TINYINT,@nobat TINYINT,@KargahBime INT)
AS
IF(@fieldName='Ezafekar')
BEGIN
	IF(@nobat<>0)
SELECT     fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc,fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdamId
,fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId)NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId
,fldMashmolBime,fldMablagh,fldBimePersonal,fldBimeKarFarma,fldBimeBikari,Prs.Prs_tblPersonalInfo.fldSh_Personali
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                    WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 /*AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1*/ AND fldType=1
 ELSE
 SELECT     fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc,fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,Com.fn_NoEstekhdam(fldAnvaEstekhdamId) AS fldNoeEstekhdamId
,fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId)NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId
,fldMashmolBime,fldMablagh,fldBimePersonal,fldBimeKarFarma,fldBimeBikari,Prs.Prs_tblPersonalInfo.fldSh_Personali
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode  INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                    WHERE fldYear=@sal AND fldMonth=@mah  AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1/* AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1*/ AND fldType=1

END
IF(@fieldName='Tatilkar')
BEGIN
	IF(@nobat<>0)
SELECT     fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc,fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,(SELECT TOP(1)    Com.tblAnvaEstekhdam.fldNoeEstekhdamId
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Prs.Prs_tblPersonalInfo.fldId ORDER BY Prs.tblHistoryNoeEstekhdam.fldId desc) AS fldNoeEstekhdamId
,fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId)NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId
,fldMashmolBime,fldMablagh,fldBimePersonal,fldBimeKarFarma,fldBimeBikari,Prs.Prs_tblPersonalInfo.fldSh_Personali
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode  INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                    WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 /*AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1*/ AND fldType=2
 ELSE
 SELECT     fldName, fldFamily,fldFatherName,fldJobeCode,fldJobDesc,fldCodemeli,Pay.tblMohasebat_PersonalInfo.fldShomareBime,fldSh_Shenasname,fldTarikhEstekhdam,(SELECT TOP(1)    Com.tblAnvaEstekhdam.fldNoeEstekhdamId
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Prs.Prs_tblPersonalInfo.fldId ORDER BY Prs.tblHistoryNoeEstekhdam.fldId desc) AS fldNoeEstekhdamId
,fldTarikhTavalod,fldMeliyat,fldJensiyat,(SELECT fldName FROM Com.tblCity WHERE fldid=fldMahalSodoorId)NameSodoor,Pay.Pay_tblPersonalInfo.fldId AS PersonalId
,fldMashmolBime,fldMablagh,fldBimePersonal,fldBimeKarFarma,fldBimeBikari,Prs.Prs_tblPersonalInfo.fldSh_Personali
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode  INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
                    WHERE fldYear=@sal AND fldMonth=@mah  AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 /*AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1*/ AND fldType=2

	
END
GO
