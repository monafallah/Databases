SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMorakhasiGroupSelect]
@fieldname Nvarchar(50),
@Year SMALLINT,
@Month TINYINT,
@NobatePardakht TINYINT,
@OrganId int,
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

	if (@fieldname=N'fldMorakhasiId')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, Com.tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblMorakhasi
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldMorakhasiId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1393) 
                      AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldMonth, ISNULL
                          ((SELECT     fldTedad
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldTedad, ISNULL
                          ((SELECT     fldSalAkharinHokm
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldSalAkharinHokm, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldNobatePardakht, CAST(0 AS bit) AS fldChecked,
					   tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
      ORDER BY fldFamily,fldName ASC

	  	if (@fieldname=N'CostCenter')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, Com.tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblMorakhasi
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldMorakhasiId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1393) 
                      AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldMonth, ISNULL
                          ((SELECT     fldTedad
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldTedad, ISNULL
                          ((SELECT     fldSalAkharinHokm
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldSalAkharinHokm, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldNobatePardakht, CAST(0 AS bit) AS fldChecked,
					   tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
       AND Pay.Pay_tblPersonalInfo.fldCostCenterId=@CostCenter_Chart
	  ORDER BY fldFamily,fldName ASC


	  	if (@fieldname=N'ChartOrgan')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, Com.tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     fldId
                              FROM         Pay.tblMorakhasi
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldMorakhasiId, ISNULL
                          ((SELECT     fldYear
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_5
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1393) 
                      AS fldYear, ISNULL
                          ((SELECT     fldMonth
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_4
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldMonth, ISNULL
                          ((SELECT     fldTedad
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_3
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldTedad, ISNULL
                          ((SELECT     fldSalAkharinHokm
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_2
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 0) 
                      AS fldSalAkharinHokm, ISNULL
                          ((SELECT     fldNobatePardakht
                              FROM         Pay.tblMorakhasi AS tblMorakhasi_1
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId) AND (fldYear = @Year) AND (fldMonth = @Month) AND (fldNobatePardakht = @NobatePardakht)), 1) 
                      AS fldNobatePardakht, CAST(0 AS bit) AS fldChecked,
					   tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
      	AND Prs_tblPersonalInfo.fldOrganPostEjraeeId IN (SELECT fldId FROM Com.tblOrganizationalPostsEjraee WHERE fldChartOrganId IN (SELECT id FROM @organ) AND fldId=Prs_tblPersonalInfo.fldOrganPostEjraeeId)
	  ORDER BY fldFamily,fldName ASC




      	COMMIT
GO
