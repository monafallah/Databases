SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSayerPardakhtGroupSelect]
@fieldname Nvarchar(50),
@Year SMALLINT,
@Month TINYINT,
@NobatePardakht TINYINT,
@MarhalePardakht TINYINT,
@fldCostCenterId INT,
@BankId INT,
@Type TINYINT,
@OrganId INT

AS 

	BEGIN TRAN
	if (@fieldname=N'fldSayerPardakht')
SELECT    Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
, ISNULL(s.fldId, 0) AS fldSayerPardakhtId, ISNULL (s.fldYear, 0) AS fldYear, ISNULL(s.fldMonth, 0) AS fldMonth, ISNULL(s.fldAmount, 0) AS fldAmount, ISNULL
(s.fldTitle, '') AS fldTitle, ISNULL(s.fldNobatePardakt, 1) AS fldNobatePardakt, ISNULL(s.fldMarhalePardakht, 1) AS fldMarhalePardakht
, CAST(0 AS bit) AS fldChecked, Pay.Pay_tblPersonalInfo.fldCostCenterId, 
Pay.tblCostCenter.fldTitle AS Expr1, ISNULL(sh.fldShomareHesab, '') AS fldShomareHesab, 
Prs.tblVaziyatEsargari.fldMoafAsMaliyat, ISNULL(s.fldKhalesPardakhti, 0) AS fldKhalesPardakhti, ISNULL(s.fldMaliyat, 0) AS fldMaliyat
, ISNULL(s.fldHasMaliyat, 0) AS fldHasMaliyat, ISNULL(sh.fldId, 0) AS fldShomareHesabsId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId inner join
					  com.tblAshkhas as a on a.fldHaghighiId=tblEmployee.fldId
					  outer apply (SELECT     top 1   fldId, fldYear, fldMonth, fldAmount, fldTitle, fldNobatePardakt, fldMarhalePardakht, fldHasMaliyat, fldMaliyat, fldKhalesPardakhti
									FROM            Pay.tblSayerPardakhts
									WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) 
									AND (fldMonth = @Month) AND (fldNobatePardakt = @NobatePardakht) AND 
                                    (fldMarhalePardakht = @MarhalePardakht))s
					outer apply (SELECT   top(1) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShomareHesab
							FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId
                              WHERE     (fldBankId = @BankId) AND (fldHesabTypeId = @Type) AND (fldAshkhasId = a.fldId))sh
                      where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
      ORDER BY fldFamily,fldName ASC
      
      
      if (@fieldname=N'fldCostCenterId')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
, ISNULL(s.fldId, 0) AS fldSayerPardakhtId, ISNULL (s.fldYear, 0) AS fldYear, ISNULL(s.fldMonth, 0) AS fldMonth, ISNULL(s.fldAmount, 0) AS fldAmount, ISNULL
(s.fldTitle, '') AS fldTitle, ISNULL(s.fldNobatePardakt, 1) AS fldNobatePardakt, ISNULL(s.fldMarhalePardakht, 1) AS fldMarhalePardakht
, CAST(0 AS bit) AS fldChecked, Pay.Pay_tblPersonalInfo.fldCostCenterId, 
Pay.tblCostCenter.fldTitle AS Expr1, ISNULL(sh.fldShomareHesab, '') AS fldShomareHesab, 
Prs.tblVaziyatEsargari.fldMoafAsMaliyat, ISNULL(s.fldKhalesPardakhti, 0) AS fldKhalesPardakhti, ISNULL(s.fldMaliyat, 0) AS fldMaliyat
, ISNULL(s.fldHasMaliyat, 0) AS fldHasMaliyat, ISNULL(sh.fldId, 0) AS fldShomareHesabsId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId inner join
					  com.tblAshkhas as a on a.fldHaghighiId=tblEmployee.fldId
					  outer apply (SELECT     top 1   fldId, fldYear, fldMonth, fldAmount, fldTitle, fldNobatePardakt, fldMarhalePardakht, fldHasMaliyat, fldMaliyat, fldKhalesPardakhti
									FROM            Pay.tblSayerPardakhts
									WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) 
									AND (fldMonth = @Month) AND (fldNobatePardakt = @NobatePardakht) AND 
                                    (fldMarhalePardakht = @MarhalePardakht))s
					outer apply (SELECT   top(1) Com.tblShomareHesabeOmoomi.fldId, Com.tblShomareHesabeOmoomi.fldShomareHesab
							FROM         Com.tblShomareHesabeOmoomi INNER JOIN
                      Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId
                              WHERE     (fldBankId = @BankId) AND (fldHesabTypeId = @Type) AND (fldAshkhasId = a.fldId))sh
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND fldCostCenterId=@fldCostCenterId  
       AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId     
      ORDER BY fldFamily,fldName ASC
      
      	COMMIT
GO
