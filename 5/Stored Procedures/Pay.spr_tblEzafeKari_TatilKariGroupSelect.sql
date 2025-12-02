SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEzafeKari_TatilKariGroupSelect]
@fieldname Nvarchar(50),
@sal NVARCHAR(4),
@mah NVARCHAR(2),
@NobatePardakht TINYINT,
@Type TINYINT,
@OrganId INT,
@CostCenter_Chart INT
AS 

	BEGIN TRAN
	DECLARE @organ TABLE (id int)
	;WITH organ as	(
	SELECT    fldId    
	FROM            Com.tblChartOrganEjraee
	WHERE fldId=@CostCenter_Chart
	UNION ALL
	SELECT t.fldId FROM Com.tblChartOrganEjraee AS t
	INNER JOIN organ ON t.fldPId=organ.fldId
	 )
	 INSERT INTO @organ 
			 ( id )
	 SELECT organ.fldId FROM organ

	if (@fieldname=N'fldEzafeKari_TatilKari')
	BEGIN
	IF(@Type=1)
	SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblEzafeKari_TatilKari
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldEzafeKari_TatilKariId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1393) AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldNobatePardakht, ISNULL
                          ((SELECT     fldCount
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldCount, ISNULL
                          ((SELECT     fldHasBime
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS bit) AS Expr1
                              FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                                                    Pay.tblMoteghayerhayeHoghoghi ON 
                                                    Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 6, 2) 
                                                   < = @mah) AND (pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId IN (88, 89, 90, 91)) AND 
                                                    Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId=Com.fn_MaxTypeEstekhdam(Pay_tblPersonalInfo.fldId) and  Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId=pay.Pay_tblPersonalInfo.fldTypeBimeId
                              ORDER BY Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra DESC, Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur DESC), 0)) AS fldHasBime, ISNULL
                          ((SELECT     fldHasMaliyat
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS BIT) AS Expr1
                              FROM         Pay.tblFiscal_Header INNER JOIN
                                                    Pay.tblFiscalTitle ON Pay.tblFiscal_Header.fldId = Pay.tblFiscalTitle.fldFiscalHeaderId INNER JOIN
                                                    Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_2 ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = tblAnvaEstekhdam_2.fldId
                              WHERE     (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 6, 2) <= @mah) AND 
                                                    (tblAnvaEstekhdam_2.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId)) AND 
                                                    (Pay.tblFiscalTitle.fldItemEstekhdamId IN (88, 89, 90, 91))
                              ORDER BY Pay.tblFiscal_Header.fldDateOfIssue DESC, Pay.tblFiscal_Header.fldEffectiveDate DESC), 0)) AS fldHasMaliyat, CAST(0 AS bit) AS fldChecked,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_1
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId            
      ORDER BY fldFamily,fldName ASC
     
     IF(@type=2)
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblEzafeKari_TatilKari
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldEzafeKari_TatilKariId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1393) AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldNobatePardakht, ISNULL
                          ((SELECT     fldCount
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldCount, ISNULL
                          ((SELECT     fldHasBime
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS bit) AS Expr1
                              FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                                                    Pay.tblMoteghayerhayeHoghoghi ON 
                                                    Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 6, 2) 
                                                   < = @mah) AND (pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId IN (88, 89, 90, 91)) AND 
                                                    Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId=Com.fn_MaxTypeEstekhdam(Pay_tblPersonalInfo.fldId) and  Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId=pay.Pay_tblPersonalInfo.fldTypeBimeId
                              ORDER BY Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra DESC, Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur DESC), 0)) AS fldHasBime, ISNULL
                          ((SELECT     fldHasMaliyat
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS BIT) AS Expr1
                              FROM         Pay.tblFiscal_Header INNER JOIN
                                                    Pay.tblFiscalTitle ON Pay.tblFiscal_Header.fldId = Pay.tblFiscalTitle.fldFiscalHeaderId INNER JOIN
                                                    Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_2 ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = tblAnvaEstekhdam_2.fldId
                              WHERE     (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 6, 2) <= @mah) AND 
                                                    (tblAnvaEstekhdam_2.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId)) AND 
                                                    (Pay.tblFiscalTitle.fldItemEstekhdamId IN (96, 97, 98, 99))
                              ORDER BY Pay.tblFiscal_Header.fldDateOfIssue DESC, Pay.tblFiscal_Header.fldEffectiveDate DESC), 0)) AS fldHasMaliyat, CAST(0 AS bit) AS fldChecked,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_1
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId             
      ORDER BY fldFamily,fldName ASC
     
     
     END
     
if (@fieldname=N'CostCenter')
	BEGIN
	IF(@Type=1)
	SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblEzafeKari_TatilKari
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldEzafeKari_TatilKariId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1393) AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldNobatePardakht, ISNULL
                          ((SELECT     fldCount
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldCount, ISNULL
                          ((SELECT     fldHasBime
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS bit) AS Expr1
                              FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                                                    Pay.tblMoteghayerhayeHoghoghi ON 
                                                    Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 6, 2) 
                                                    = @mah) AND (Com.tblAnvaEstekhdam.fldNoeEstekhdamId IN (88, 89, 90, 91)) AND 
                                                    (Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId))
                              ORDER BY Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra DESC, Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur DESC), 0)) AS fldHasBime, ISNULL
                          ((SELECT     fldHasMaliyat
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS BIT) AS Expr1
                              FROM         Pay.tblFiscal_Header INNER JOIN
                                                    Pay.tblFiscalTitle ON Pay.tblFiscal_Header.fldId = Pay.tblFiscalTitle.fldFiscalHeaderId INNER JOIN
                                                    Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_2 ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = tblAnvaEstekhdam_2.fldId
                              WHERE     (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 6, 2) <= @mah) AND 
                                                    (tblAnvaEstekhdam_2.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId)) AND 
                                                    (Pay.tblFiscalTitle.fldItemEstekhdamId IN (88, 89, 90, 91))
                              ORDER BY Pay.tblFiscal_Header.fldDateOfIssue DESC, Pay.tblFiscal_Header.fldEffectiveDate DESC), 0)) AS fldHasMaliyat, CAST(0 AS bit) AS fldChecked,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_1
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId  
	   AND Pay.Pay_tblPersonalInfo.fldCostCenterId=@CostCenter_Chart
	         
      ORDER BY fldFamily,fldName ASC
     
     IF(@type=2)
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblEzafeKari_TatilKari
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldEzafeKari_TatilKariId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1393) AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldNobatePardakht, ISNULL
                          ((SELECT     fldCount
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldCount, ISNULL
                          ((SELECT     fldHasBime
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS bit) AS Expr1
                              FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                                                    Pay.tblMoteghayerhayeHoghoghi ON 
                                                    Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 6, 2) 
                                                    = @mah) AND (Com.tblAnvaEstekhdam.fldNoeEstekhdamId IN (96, 97, 98, 99)) AND 
                                                    (Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId))
                              ORDER BY Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra DESC, Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur DESC), 0)) AS fldHasBime, ISNULL
                          ((SELECT     fldHasMaliyat
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS BIT) AS Expr1
                              FROM         Pay.tblFiscal_Header INNER JOIN
                                                    Pay.tblFiscalTitle ON Pay.tblFiscal_Header.fldId = Pay.tblFiscalTitle.fldFiscalHeaderId INNER JOIN
                                                    Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_2 ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = tblAnvaEstekhdam_2.fldId
                              WHERE     (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 6, 2) <= @mah) AND 
                                                    (tblAnvaEstekhdam_2.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId)) AND 
                                                    (Pay.tblFiscalTitle.fldItemEstekhdamId IN (96, 97, 98, 99))
                              ORDER BY Pay.tblFiscal_Header.fldDateOfIssue DESC, Pay.tblFiscal_Header.fldEffectiveDate DESC), 0)) AS fldHasMaliyat, CAST(0 AS bit) AS fldChecked,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_1
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId             
       AND Pay.Pay_tblPersonalInfo.fldCostCenterId=@CostCenter_Chart
	  ORDER BY fldFamily,fldName ASC
     
     
     END
     



	 if (@fieldname=N'ChartOrgan')
	BEGIN
	IF(@Type=1)
	SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblEzafeKari_TatilKari
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldEzafeKari_TatilKariId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1393) AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldNobatePardakht, ISNULL
                          ((SELECT     fldCount
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldCount, ISNULL
                          ((SELECT     fldHasBime
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS bit) AS Expr1
                              FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                                                    Pay.tblMoteghayerhayeHoghoghi ON 
                                                    Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 6, 2) 
                                                    = @mah) AND (Com.tblAnvaEstekhdam.fldNoeEstekhdamId IN (88, 89, 90, 91)) AND 
                                                    (Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId))
                              ORDER BY Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra DESC, Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur DESC), 0)) AS fldHasBime, ISNULL
                          ((SELECT     fldHasMaliyat
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS BIT) AS Expr1
                              FROM         Pay.tblFiscal_Header INNER JOIN
                                                    Pay.tblFiscalTitle ON Pay.tblFiscal_Header.fldId = Pay.tblFiscalTitle.fldFiscalHeaderId INNER JOIN
                                                    Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_2 ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = tblAnvaEstekhdam_2.fldId
                              WHERE     (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 6, 2) <= @mah) AND 
                                                    (tblAnvaEstekhdam_2.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId)) AND 
                                                    (Pay.tblFiscalTitle.fldItemEstekhdamId IN (88, 89, 90, 91))
                              ORDER BY Pay.tblFiscal_Header.fldDateOfIssue DESC, Pay.tblFiscal_Header.fldEffectiveDate DESC), 0)) AS fldHasMaliyat, CAST(0 AS bit) AS fldChecked,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_1
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId            
		AND Prs_tblPersonalInfo.fldOrganPostEjraeeId IN (SELECT fldId FROM Com.tblOrganizationalPostsEjraee WHERE fldChartOrganId IN (SELECT id FROM @organ) AND fldId=Prs_tblPersonalInfo.fldOrganPostEjraeeId)
	  ORDER BY fldFamily,fldName ASC
     
     IF(@type=2)
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblEzafeKari_TatilKari
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldEzafeKari_TatilKariId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1393) AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 1) AS fldNobatePardakht, ISNULL
                          ((SELECT     fldCount
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), 0) AS fldCount, ISNULL
                          ((SELECT     fldHasBime
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS bit) AS Expr1
                              FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                                                    Pay.tblMoteghayerhayeHoghoghi ON 
                                                    Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 6, 2) 
                                                    = @mah) AND (Com.tblAnvaEstekhdam.fldNoeEstekhdamId IN (96, 97, 98, 99)) AND 
                                                    (Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId))
                              ORDER BY Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra DESC, Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur DESC), 0)) AS fldHasBime, ISNULL
                          ((SELECT     fldHasMaliyat
                              FROM         Pay.tblEzafeKari_TatilKari AS tblEzafeKari_TatilKari_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht) AND 
                                                    (fldType = @Type)), ISNULL
                          ((SELECT     TOP (1) CAST(1 AS BIT) AS Expr1
                              FROM         Pay.tblFiscal_Header INNER JOIN
                                                    Pay.tblFiscalTitle ON Pay.tblFiscal_Header.fldId = Pay.tblFiscalTitle.fldFiscalHeaderId INNER JOIN
                                                    Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_2 ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = tblAnvaEstekhdam_2.fldId
                              WHERE     (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 1, 4) <= @sal) AND (SUBSTRING(Pay.tblFiscal_Header.fldEffectiveDate, 6, 2) <= @mah) AND 
                                                    (tblAnvaEstekhdam_2.fldNoeEstekhdamId = Com.fn_MaxTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldId)) AND 
                                                    (Pay.tblFiscalTitle.fldItemEstekhdamId IN (96, 97, 98, 99))
                              ORDER BY Pay.tblFiscal_Header.fldDateOfIssue DESC, Pay.tblFiscal_Header.fldEffectiveDate DESC), 0)) AS fldHasMaliyat, CAST(0 AS bit) AS fldChecked,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_1
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId             
     AND Prs_tblPersonalInfo.fldOrganPostEjraeeId IN (SELECT fldId FROM Com.tblOrganizationalPostsEjraee WHERE fldChartOrganId IN (SELECT id FROM @organ) AND fldId=Prs_tblPersonalInfo.fldOrganPostEjraeeId)
	  ORDER BY fldFamily,fldName ASC
     
     
     end


      	COMMIT
GO
