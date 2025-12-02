SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKomakGheyerNaghdiGroupSelect]
 @fieldname NVARCHAR(50),
 @Month TINYINT,
 @Year SMALLINT,
 @fldNoeMostamer BIT,
 @PersonalId INT,
 @OrganId INT,
@CostCenter_Chart INT
AS
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

IF(@fieldname='KomakId')

SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Pay.tblKomakGheyerNaghdi
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldId, ISNULL
                          ((SELECT     TOP (1) fldShomareHesabId
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_9
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldShomareHesabId, ISNULL
                          ((SELECT     TOP (1) fldNoeMostamer
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_8
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldNoeMostamer, ISNULL
                          ((SELECT     TOP (1) fldYear
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_7
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldYear, ISNULL
                          ((SELECT     TOP (1) fldMonth
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_6
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMonth, ISNULL
                          ((SELECT     TOP (1) fldMablagh
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_5
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMablagh, ISNULL
                          ((SELECT     TOP (1) fldKhalesPardakhti
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_4
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldKhalesPardakhti, ISNULL
                          ((SELECT     TOP (1) fldMaliyat
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_3
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMaliyat, ISNULL
                          ((SELECT     TOP (1)Com.tblShomareHesabeOmoomi.fldShomareHesab
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_2 INNER JOIN
                                                   Com.tblShomareHesabeOmoomi ON tblKomakGheyerNaghdi_2.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                              WHERE     (tblKomakGheyerNaghdi_2.fldMonth = @Month) AND (tblKomakGheyerNaghdi_2.fldYear = @Year) AND 
                                                    (tblKomakGheyerNaghdi_2.fldNoeMostamer = @fldNoeMostamer) AND (tblKomakGheyerNaghdi_2.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldShomareHesab, ISNULL
                          ((SELECT     TOP (1) CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS Expr1
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_1
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldNoeMostamerName
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) = @OrganId        
      ORDER BY fldFamily,fldName ASC



	  IF(@fieldname='CostCenter')

SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Pay.tblKomakGheyerNaghdi
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldId, ISNULL
                          ((SELECT     TOP (1) fldShomareHesabId
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_9
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldShomareHesabId, ISNULL
                          ((SELECT     TOP (1) fldNoeMostamer
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_8
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldNoeMostamer, ISNULL
                          ((SELECT     TOP (1) fldYear
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_7
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldYear, ISNULL
                          ((SELECT     TOP (1) fldMonth
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_6
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMonth, ISNULL
                          ((SELECT     TOP (1) fldMablagh
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_5
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMablagh, ISNULL
                          ((SELECT     TOP (1) fldKhalesPardakhti
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_4
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldKhalesPardakhti, ISNULL
                          ((SELECT     TOP (1) fldMaliyat
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_3
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMaliyat, ISNULL
                          ((SELECT     TOP (1)Com.tblShomareHesabeOmoomi.fldShomareHesab
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_2 INNER JOIN
                                                   Com.tblShomareHesabeOmoomi ON tblKomakGheyerNaghdi_2.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                              WHERE     (tblKomakGheyerNaghdi_2.fldMonth = @Month) AND (tblKomakGheyerNaghdi_2.fldYear = @Year) AND 
                                                    (tblKomakGheyerNaghdi_2.fldNoeMostamer = @fldNoeMostamer) AND (tblKomakGheyerNaghdi_2.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldShomareHesab, ISNULL
                          ((SELECT     TOP (1) CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS Expr1
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_1
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldNoeMostamerName
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) = @OrganId        
     AND Pay.Pay_tblPersonalInfo.fldCostCenterId=@CostCenter_Chart         
	  ORDER BY fldFamily,fldName ASC



IF(@fieldname='ChartOrgan')

SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, 
                      tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Pay.tblKomakGheyerNaghdi
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldId, ISNULL
                          ((SELECT     TOP (1) fldShomareHesabId
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_9
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldShomareHesabId, ISNULL
                          ((SELECT     TOP (1) fldNoeMostamer
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_8
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldNoeMostamer, ISNULL
                          ((SELECT     TOP (1) fldYear
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_7
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldYear, ISNULL
                          ((SELECT     TOP (1) fldMonth
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_6
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMonth, ISNULL
                          ((SELECT     TOP (1) fldMablagh
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_5
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMablagh, ISNULL
                          ((SELECT     TOP (1) fldKhalesPardakhti
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_4
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldKhalesPardakhti, ISNULL
                          ((SELECT     TOP (1) fldMaliyat
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_3
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldMaliyat, ISNULL
                          ((SELECT     TOP (1)Com.tblShomareHesabeOmoomi.fldShomareHesab
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_2 INNER JOIN
                                                   Com.tblShomareHesabeOmoomi ON tblKomakGheyerNaghdi_2.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId
                              WHERE     (tblKomakGheyerNaghdi_2.fldMonth = @Month) AND (tblKomakGheyerNaghdi_2.fldYear = @Year) AND 
                                                    (tblKomakGheyerNaghdi_2.fldNoeMostamer = @fldNoeMostamer) AND (tblKomakGheyerNaghdi_2.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldShomareHesab, ISNULL
                          ((SELECT     TOP (1) CASE WHEN fldNoeMostamer = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS Expr1
                              FROM         Pay.tblKomakGheyerNaghdi AS tblKomakGheyerNaghdi_1
                              WHERE     (fldMonth = @Month) AND (fldYear = @Year) AND (fldNoeMostamer = @fldNoeMostamer) AND (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)), 0) 
                      AS fldNoeMostamerName
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
       where  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) = @OrganId        
           		AND Prs_tblPersonalInfo.fldOrganPostejraeeId IN (SELECT fldId FROM Com.tblOrganizationalPostsEjraee WHERE fldChartOrganId IN (SELECT id FROM @organ) AND fldId=Prs_tblPersonalInfo.fldOrganPostEjraeeId)

	  ORDER BY fldFamily,fldName ASC
GO
