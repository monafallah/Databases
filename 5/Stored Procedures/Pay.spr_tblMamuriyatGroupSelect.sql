SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMamuriyatGroupSelect]
@fieldname Nvarchar(50),
@sal SMALLINT,
@mah TINYINT,
@NobatePardakht  TINYINT,
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


	if (@fieldname=N'fldMamuriyat')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblMamuriyat
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldMamuriyatId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_11
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1393) 
                      AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_10
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_9
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldNobatePardakht, ISNULL
                          ((SELECT     fldBaBeytute
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_8
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBaBeytute, ISNULL
                          ((SELECT     fldBeduneBeytute
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_7
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBeduneBeytute, ISNULL
                          ((SELECT     fldBa10
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa10, ISNULL
                          ((SELECT     fldBa20
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa20, ISNULL
                          ((SELECT     fldBa30
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa30, ISNULL
                          ((SELECT     fldBe10
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe10, ISNULL
                          ((SELECT     fldBe20
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe20, ISNULL
                          ((SELECT     fldBe30
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe30, ISNULL
                          ((SELECT     TOP (1) Com.tblAnvaEstekhdam.fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY Prs.tblHistoryNoeEstekhdam.fldTarikh DESC), 0) AS fldNoeEstekhdamId, CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId            
      	ORDER BY fldFamily,fldName ASC

IF (@fieldname=N'CostCenter')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblMamuriyat
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldMamuriyatId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_11
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1393) 
                      AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_10
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_9
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldNobatePardakht, ISNULL
                          ((SELECT     fldBaBeytute
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_8
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBaBeytute, ISNULL
                          ((SELECT     fldBeduneBeytute
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_7
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBeduneBeytute, ISNULL
                          ((SELECT     fldBa10
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa10, ISNULL
                          ((SELECT     fldBa20
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa20, ISNULL
                          ((SELECT     fldBa30
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa30, ISNULL
                          ((SELECT     fldBe10
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe10, ISNULL
                          ((SELECT     fldBe20
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe20, ISNULL
                          ((SELECT     fldBe30
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe30, ISNULL
                          ((SELECT     TOP (1) Com.tblAnvaEstekhdam.fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY Prs.tblHistoryNoeEstekhdam.fldTarikh DESC), 0) AS fldNoeEstekhdamId, CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	   AND Pay.Pay_tblPersonalInfo.fldCostCenterId=@CostCenter_Chart            
      	
	
		ORDER BY fldFamily,fldName ASC



		if (@fieldname=N'ChartOrgan')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblMamuriyat
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldMamuriyatId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_11
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1393) 
                      AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_10
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldMonth, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_9
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldNobatePardakht, ISNULL
                          ((SELECT     fldBaBeytute
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_8
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBaBeytute, ISNULL
                          ((SELECT     fldBeduneBeytute
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_7
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBeduneBeytute, ISNULL
                          ((SELECT     fldBa10
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_6
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa10, ISNULL
                          ((SELECT     fldBa20
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa20, ISNULL
                          ((SELECT     fldBa30
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBa30, ISNULL
                          ((SELECT     fldBe10
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe10, ISNULL
                          ((SELECT     fldBe20
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe20, ISNULL
                          ((SELECT     fldBe30
                              FROM         Pay.tblMamuriyat AS tblMamuriyat_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @sal) AND (fldMonth = @mah) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldBe30, ISNULL
                          ((SELECT     TOP (1) Com.tblAnvaEstekhdam.fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                                                    Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY Prs.tblHistoryNoeEstekhdam.fldTarikh DESC), 0) AS fldNoeEstekhdamId, CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId            
      		AND Prs_tblPersonalInfo.fldOrganPostEjraeeId IN (SELECT fldId FROM Com.tblOrganizationalPostsEjraee WHERE fldChartOrganId IN (SELECT id FROM @organ) AND fldId=Prs_tblPersonalInfo.fldOrganPostEjraeeId)
		ORDER BY fldFamily,fldName ASC

      	COMMIT
GO
