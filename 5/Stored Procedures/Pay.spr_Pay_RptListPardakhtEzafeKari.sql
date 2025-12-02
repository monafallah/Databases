SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPardakhtEzafeKari] (@FieldName NVARCHAR(50),@CostCenterId INT,@Sal SMALLINT,@mah TINYINT,@personalId INT,@nobatPardakht TINYINT,@organId int)
AS
IF(@FieldName='EzafeKar')
BEGIN
IF(@personalId<>0)
	SELECT      com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh, Pay.tblMohasebatEzafeKari_TatilKari.fldTedad, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldBimeKarFarma, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldjam,
                       Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat, Pay.tblMohasebatEzafeKari_TatilKari.fldBimePersonal, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldSahmBimeKarfarma, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat + Pay.tblMohasebatEzafeKari_TatilKari.fldBimePersonal + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS
                       fldKosurat,Com.fn_month(@mah) AS fldMah,@sal AS fldsal,fldKhalesPardakhti
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
                      WHERE Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenterId AND Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Sal
                      AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@mah AND tblMohasebatEzafeKari_TatilKari.fldNobatPardakht=@nobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=1
                      AND Pay.Pay_tblPersonalInfo.fldId=@personalId and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
                      ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
 ELSE
    SELECT     com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh, Pay.tblMohasebatEzafeKari_TatilKari.fldTedad, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldBimeKarFarma, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldjam,
                       Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat, Pay.tblMohasebatEzafeKari_TatilKari.fldBimePersonal, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldSahmBimeKarfarma, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat + Pay.tblMohasebatEzafeKari_TatilKari.fldBimePersonal + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS
                        fldKosurat,Com.fn_month(@mah) AS fldMah,@sal AS fldsal,fldKhalesPardakhti
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId
                      WHERE Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenterId AND Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Sal
                      AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@mah AND fldNobatPardakht=@nobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=1
					  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
    ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
END

IF(@FieldName='TatilKar')
BEGIN
IF(@personalId<>0)
	SELECT    com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh, Pay.tblMohasebatEzafeKari_TatilKari.fldTedad, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldBimeKarFarma, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldjam,
                       Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat, Pay.tblMohasebatEzafeKari_TatilKari.fldBimePersonal, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldSahmBimeKarfarma, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat + Pay.tblMohasebatEzafeKari_TatilKari.fldBimePersonal + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS
                    fldKosurat,Com.fn_month(@mah) AS fldMah,@sal AS fldsal,fldKhalesPardakhti
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
                      WHERE Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenterId AND Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Sal
                      AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@mah AND fldNobatPardakht=@nobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=2
                      AND Pay.Pay_tblPersonalInfo.fldId=@personalId and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
 ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
 ELSE
    SELECT      com.fn_FamilyEmployee(Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh, Pay.tblMohasebatEzafeKari_TatilKari.fldTedad, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldBimeKarFarma, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldjam,
                       Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat, Pay.tblMohasebatEzafeKari_TatilKari.fldBimePersonal, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS fldSahmBimeKarfarma, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldMaliyat + Pay.tblMohasebatEzafeKari_TatilKari.fldBimePersonal + Pay.tblMohasebatEzafeKari_TatilKari.fldBimeKarFarma+Pay.tblMohasebatEzafeKari_TatilKari.fldBimeBikari AS
                        fldKosurat,Com.fn_month(@mah) AS fldMah,@sal AS fldsal,fldKhalesPardakhti
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId
                      WHERE Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@CostCenterId AND Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Sal
                      AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@mah AND fldNobatPardakht=@nobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=2
					  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
    ORDER BY tblEmployee.fldFamily,tblEmployee.fldName
END
GO
