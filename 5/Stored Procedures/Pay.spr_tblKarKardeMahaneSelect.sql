SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardeMahaneSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Year nvarchar(4),
	@Month nvarchar(2),
	@NobatePardakht TINYINT,
	@Id INT,
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,tblKarKardeMahane.fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblKarKardeMahane.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC

	if (@fieldname=N'RptEstelagi')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,tblKarKardeMahane.fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldYear=@Year and fldMah=@Month  and  Pay.tblKarKardeMahane.fldEstelagi<>0  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldName_Father

    if (@fieldname=N'RptGheybat')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,tblKarKardeMahane.fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldYear=@Year and fldMah=@Month  and  Pay.tblKarKardeMahane.fldGheybat<>0  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldName_Father

	if (@fieldname=N'RptMeetingCount')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,tblKarKardeMahane.fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE   fldYear=@Year and fldMah=@Month  and  Pay.tblKarKardeMahane.fldMeetingCount<>0  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldName_Father

if (@fieldname=N'RptMamoriat')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,tblKarKardeMahane.fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldYear=@Year and fldMah=@Month  and   Pay.tblKarKardeMahane.fldMamoriatBaBeitote+fldMamoriatBedoneBeitote+fldBa10+fldBa20+fldBa30+fldBe10+fldBe20+fldBe30<>0  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
   order by fldName_Father

	if (@fieldname=N'RptEzafeKari')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,tblKarKardeMahane.fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldYear=@Year and fldMah=@Month  and   Pay.tblKarKardeMahane.fldEzafeKari<>0  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldName_Father

	if (@fieldname=N'RptTatileKari')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,tblKarKardeMahane.fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldYear=@Year and fldMah=@Month  and   Pay.tblKarKardeMahane.fldTatileKari<>0  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
   order by fldName_Father

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblKarKardeMahane.fldDesc LIKE @Value 
    order by fldYear desc,fldMah DESC

if (@fieldname=N'CheckSave')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
						  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblKarKardeMahane.fldPersonalId = @Value and Pay.tblKarKardeMahane.fldYear = @Year and Pay.tblKarKardeMahane.fldMah = @Month AND fldNobatePardakht=@NobatePardakht
    order by fldYear desc,fldMah desc
    
    if (@fieldname=N'CheckEdit')
		SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
			  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
			FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                     
                    WHERE  Pay.tblKarKardeMahane.fldId<>@Id and Pay.tblKarKardeMahane.fldPersonalId = @Value and Pay.tblKarKardeMahane.fldYear = @Year and Pay.tblKarKardeMahane.fldMah = @Month AND fldNobatePardakht=@NobatePardakht
    order by fldYear desc,fldMah desc
    
if (@fieldname=N'fldPersonalId')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblKarKardeMahane.fldPersonalId like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah desc
    
    if (@fieldname=N'CheckPersonalId')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      	WHERE  Pay.tblKarKardeMahane.fldPersonalId like @Value
    
    
    if (@fieldname=N'Mohasebe')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldYear like @Year AND fldMah=@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
    
       if (@fieldname=N'fldName_Father_Mohasebe')
SELECT  TOP(@h)* FROM (	SELECT    Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblKarKardeMahane.fldYear like @Year AND fldMah=@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    )t
    WHERE t.fldName_Father LIKE @Value
    
       if (@fieldname=N'fldCodemeli_Mohasebe')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM        Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldYear like @Year AND fldMah=@Month AND fldNobatePardakht=@NobatePardakht AND fldCodemeli LIKE @Value
	AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
    
       if (@fieldname=N'fldSh_Personali_Mohasebe')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldYear like @Year AND fldMah=@Month AND fldNobatePardakht=@NobatePardakht AND fldSh_Personali LIKE @Value
   AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
    
       if (@fieldname=N'fldNobatePardakhtS_Mohasebe')
SELECT TOP(@h) * FROM (	SELECT     Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldYear like @Year AND fldMah=@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
  )t
    WHERE fldNobatePardakhtS LIKE @Value
    
    
    
       if (@fieldname=N'fldMonth_Mohasebe')
SELECT   * FROM (	SELECT   TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldYear like @Year AND fldMah=@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC)t
    WHERE fldMonth LIKE @Value
    

    
    
    
    if (@fieldname=N'fldYear')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                     
	WHERE  Pay.tblKarKardeMahane.fldYear like @Value  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah desc
    
    if (@fieldname=N'fldMah')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldMah like @Value  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah desc

	 if (@fieldname=N'fldMah_Year')
		SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE   Pay.tblKarKardeMahane.fldYear like @Year and Pay.tblKarKardeMahane.fldMah like @Month  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah desc
    
    if (@fieldname=N'fldKarkard')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      	WHERE  Pay.tblKarKardeMahane.fldKarkard like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
    
        if (@fieldname=N'fldName_Father_YM')
SELECT TOP(@h)* FROM (	SELECT    Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	)t
	WHERE  fldName_Father like @Value AND t.fldYear=@Year AND t.fldMah=@Month  
    order by fldYear desc,fldMah DESC
    
    
       if (@fieldname=N'fldCodemeli_YM')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  tblEmployee.fldCodemeli like @Value AND fldYear=@Year AND fldMah=@Month AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
           if (@fieldname=N'fldSh_Personali_YM')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldSh_Personali like @Value AND fldYear=@Year AND fldMah=@Month AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
    
      if (@fieldname=N'fldKarkard_YM')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldKarkard like @Value AND fldYear=@Year AND fldMah=@Month AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
          if (@fieldname=N'fldMonth_YM')
SELECT    * FROM (	SELECT    Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId)t
	WHERE  fldMonth like @Value AND fldYear=@Year AND fldMah=@Month  
    order by fldYear desc,fldMah DESC
    
         if (@fieldname=N'fldYear_YM')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE   fldYear=@Year AND fldMah=@Month AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
    
           if (@fieldname=N'fldNobatePardakhtS_YM')
SELECT TOP(@h) * FROM (	SELECT    Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	)t
	WHERE  fldNobatePardakhtS like @Value AND t.fldYear=@Year AND t.fldMah=@Month  
    order by fldYear desc,fldMah DESC
    
    
    
           if (@fieldname=N'fldNobatePardakht_YM')
	SELECT   Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId and  fldNobatePardakht = @Value AND fldYear=@Year AND fldMah=@Month  
	
	   if (@fieldname=N'fldNobatePardakht_YM_Id')
	SELECT   Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE fldPersonalId=@id  and  fldNobatePardakht = @Value AND fldYear=@Year AND fldMah=@Month  
   
    
    if (@fieldname=N'fldGheybat')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldGheybat like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId 
	order by fldYear desc,fldMah desc
	
	if (@fieldname=N'fldNobateKari')
		SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
					,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldNobateKari like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah desc
    
    if (@fieldname=N'fldEzafeKari')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblKarKardeMahane.fldEzafeKari like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah desc
    
       if (@fieldname=N'fldCostCenterId')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldCostCenterId = @Value AND fldYear=@year AND fldMah=@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah desc
    
    	if (@fieldname=N'ALL')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
    
    
	if (@fieldname=N'')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
     order by fldYear desc,fldMah DESC
     
     if (@fieldname=N'fldPersonalId_Id')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC

 if (@fieldname=N'fldPersonalId_Year')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   fldYear LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC


 if (@fieldname=N'fldPersonalId_Month')
	SELECT     TOP (@h)* FROM (SELECT  Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId)t
	WHERE fldPersonalId=@Id and   fldMonth LIKE @Value  
    order by fldYear desc,fldMah DESC



 if (@fieldname=N'fldPersonalId_Karkard')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldKarkard LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC



 if (@fieldname=N'fldPersonalId_Gheybat')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldGheybat LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC



 if (@fieldname=N'fldPersonalId_NobateKari')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldNobateKari LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC


 if (@fieldname=N'fldPersonalId_EzafeKari')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldEzafeKari LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC


 if (@fieldname=N'fldPersonalId_TatileKari')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldTatileKari like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC

	
 if (@fieldname=N'fldPersonalId_Mosaedeh')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldMosaedeh like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC

	
 if (@fieldname=N'fldPersonalId_NobatePardakht')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldNobatePardakht like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC
    
	
		
 if (@fieldname=N'fldPersonalId_MamoriatBaBeitote')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldMamoriatBaBeitote like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC 


	 if (@fieldname=N'fldPersonalId_MamoriatBedoneBeitote')
	SELECT     TOP (@h) Pay.tblKarKardeMahane.fldId, Pay.tblKarKardeMahane.fldPersonalId, Pay.tblKarKardeMahane.fldYear, Pay.tblKarKardeMahane.fldMah, 
                      Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, Pay.tblKarKardeMahane.fldNobateKari, Pay.tblKarKardeMahane.fldEzafeKari, 
                      Pay.tblKarKardeMahane.fldTatileKari, Pay.tblKarKardeMahane.fldMamoriatBaBeitote, Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote, 
                      Pay.tblKarKardeMahane.fldMosaedeh, Pay.tblKarKardeMahane.fldNobatePardakht, Pay.tblKarKardeMahane.fldFlag, Pay.tblKarKardeMahane.fldGhati, 
                      Pay.tblKarKardeMahane.fldBa10, Pay.tblKarKardeMahane.fldBa20, Pay.tblKarKardeMahane.fldBa30, Pay.tblKarKardeMahane.fldBe10, 
                      Pay.tblKarKardeMahane.fldBe20, Pay.tblKarKardeMahane.fldBe30, Pay.tblKarKardeMahane.fldUserId, Pay.tblKarKardeMahane.fldDate, 
                      Pay.tblKarKardeMahane.fldDesc, Pay.Pay_tblPersonalInfo.fldShomareBime, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrS, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazad30SalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.Pay_tblPersonalInfo.fldJobeCode, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                      Com.fn_nobatePardakht(Pay.tblKarKardeMahane.fldNobatePardakht) AS fldNobatePardakhtS, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.fn_month(Pay.tblKarKardeMahane.fldMah) AS fldMonth,
                          (SELECT     fldNoeEstekhdamId
                            FROM          Com.tblAnvaEstekhdam
                            WHERE      (fldId = Com.fn_MaxPersonalTypeEstekhdam(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId))) AS fldTypeEstekhdamId, 
                      Pay.Pay_tblPersonalInfo.fldCostCenterId, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId
				  ,(SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId =Pay.Pay_tblPersonalInfo.fldId )
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusId
                              ,(SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPayPersonalInfoId= Pay.Pay_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC)AS  fldStatusTitle,fldShift,fldMoavaghe,fldAzTarikhMoavaghe,fldTaTarikhMoavaghe,case when fldMoavaghe=1 then N'بلی' else N'خیر' end fldMoavagheName,isnull(cast (fldAzTarikhMoavaghe as varchar(10)),'')fldAzTarikhMoavagheS,isnull(cast (fldTaTarikhMoavaghe as varchar(10)),'')fldTaTarikhMoavagheS,fldMeetingCount,fldEstelagi
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id and   Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    order by fldYear desc,fldMah DESC 
     
	COMMIT
GO
