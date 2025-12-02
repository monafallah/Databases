SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_SelectPayPersonalInfo_Ezafekar](@fieldname NVARCHAR(50),@h INT,@Costcenter_ChartOrganId INT,@organId INT,@year SMALLINT,@mah TINYINT)
	AS
	if (@h=0) set @h=2147483647
	DECLARE @organ TABLE (id int)
	;WITH organ as	(
	SELECT    fldId    
	FROM            Com.tblChartOrganEjraee
	WHERE fldId=@Costcenter_ChartOrganId
	UNION ALL
	SELECT t.fldId FROM Com.tblChartOrganEjraee AS t
	INNER JOIN organ ON t.fldPId=organ.fldId
	 )
	 INSERT INTO @organ 
			 ( id )
	 SELECT organ.fldId FROM organ
	
	
	IF(@fieldname='CostCenter')
	begin
SELECT     TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, Pay.Pay_tblPersonalInfo.fldCostCenterId, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, 
                      Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, tblEmployee.fldFamily + '-' +tblEmployee.fldName AS fldName, 
                      fldFatherName, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, 
                      Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, Pay.Pay_tblPersonalInfo.fldJobeCode, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS UserName, 
                      Prs.Prs_tblPersonalInfo.fldEsargariId,fldEzafeKari,fldGhati
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Pay.Pay_tblPersonalInfo INNER JOIN
                      Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                      Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId ON 
                      Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblKarKardeMahane ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblKarKardeMahane.fldPersonalId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
	WHERE  /*fldCostCenterId = @Costcenter_ChartOrganId AND*/ Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId  AND fldmah=@mah AND fldYear=@year --AND fldEzafeKari<>0
	ORDER BY fldFamily,fldName ASC
	end
		
	IF(@fieldname='ChartOrgan')
SELECT     TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                      Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, Pay.Pay_tblPersonalInfo.fldCostCenterId, 
                      Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, 
                      Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, tblEmployee.fldName + '-' + tblEmployee.fldFamily AS fldName, 
                      fldFatherName, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, 
                      Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, Pay.Pay_tblPersonalInfo.fldJobeCode, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) 
                      THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS UserName, 
                      Prs.Prs_tblPersonalInfo.fldEsargariId,fldEzafeKari,fldGhati
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Pay.Pay_tblPersonalInfo INNER JOIN
                      Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                      Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId ON 
                      Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblKarKardeMahane ON Pay.Pay_tblPersonalInfo.fldId = Pay.tblKarKardeMahane.fldPersonalId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldOrganPostEjraeeId IN(SELECT fldId FROM Com.tblOrganizationalPostsEjraee WHERE fldChartOrganId IN (SELECT id FROM @organ))  AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId  AND fldmah=@mah AND fldYear=@year --AND fldEzafeKari<>0
	ORDER BY fldFamily,fldName ASC
	
GO
