SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_tblPersonalInfoSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value= Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
  SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
                  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle, FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 
FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.Pay_tblPersonalInfo.fldId = @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC

	if (@fieldname=N'fldId_BimeTakmili')
  SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
                  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 
FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.Pay_tblPersonalInfo.fldId = @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId and fldBimeTakmili=1
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC


	if (@fieldname=N'CheckMohasebatShomareBime')
  SELECT  Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
                  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 
FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId inner join
				  pay.tblKarKardeMahane as k on k.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId
	WHERE  k.fldYear = @Value and k.fldMah=@h AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	and (Pay_tblPersonalInfo.fldShomareBime='' )
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC

	if (@fieldname=N'fldDesc')
  SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.Pay_tblPersonalInfo.fldDesc LIKE @Value 
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC


if (@fieldname=N'fldName_Family')
	SELECT  TOP(@h)  *	from(SELECT Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	) as temp
	WHERE   temp.UserName like  @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId


	if (@fieldname=N'fldName_Father')
	SELECT   TOP(@h)  *
	from(  SELECT Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId) as temp
	WHERE temp.fldName_Father like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId

	if (@fieldname=N'fldName_Father_BimeTakmili')
	SELECT   TOP(@h)  *
	from(  SELECT Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId) as temp
	WHERE temp.fldName_Father like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId and fldBimeTakmili=1

	if (@fieldname=N'fldNationalCode')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  tblEmployee.fldCodemeli like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'fldNationalCode_BimeTakmili')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  tblEmployee.fldCodemeli like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId and fldBimeTakmili=1
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC

	if (@fieldname=N'fldShomarePersoneli')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldSh_Personali like @Value AND  Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC

	if (@fieldname=N'fldShomarePersoneli_BimeTakmili')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldSh_Personali like @Value AND  Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId and fldBimeTakmili=1
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC

	if (@fieldname=N'fldShomareBime')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldShomareBime like @Value AND  Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC

	if (@fieldname=N'CheckShomareBime')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldShomareBime like @Value AND  fldTypeBimeId=@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'fldPrs_PersonalInfoId')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldPrs_PersonalInfoId = @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'CheckPrs_PersonalInfoId')
	              SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldPrs_PersonalInfoId = @Value 
	
		if (@fieldname=N'CheckPrs_PersonalInfoId')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldPrs_PersonalInfoId = @Value
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'fldInsuranceWorkShopId')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldInsuranceWorkShopId like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'CheckInsuranceWorkShopId')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldInsuranceWorkShopId like @Value
		ORDER BY fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'fldCostCenterId')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldCostCenterId like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY fldFamily,tblEmployee.fldName ASC
	
	
	
	if (@fieldname=N'CheckCostCenterId')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldCostCenterId like @Value
	ORDER BY fldFamily,tblEmployee.fldName ASC
	
	
		if (@fieldname=N'fldJobeCode')
	               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldJobeCode like @Value AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'CheckShomareBime')
               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  fldShomareBime = @Value 
	ORDER BY fldFamily,tblEmployee.fldName ASC
	
	
	
	
		if (@fieldname=N'Active')
                SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND   Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY fldFamily,tblEmployee.fldName ASC
	
		if (@fieldname=N'Active_fldJobeCode')
               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 
FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND   Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId AND fldJobeCode LIKE @Value
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	
		if (@fieldname=N'Active_fldName_Father')
SELECT  TOP(@h)* FROM ( SELECT Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
WHERE  (Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId, N'hoghoghi') = 1) AND (Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) = @OrganId)
                      	)t
                      	WHERE  t.fldName_Father LIKE @Value
	
	
			if (@fieldname=N'Active_fldNationalCode')
               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND fldCodemeli LIKE @Value and   Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
			if (@fieldname=N'Active_fldShomareBime')
               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND fldShomareBime LIKE @Value and   Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	
			if (@fieldname=N'Active_fldShomarePersoneli')
              SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY fldid) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE  Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND fldSh_Personali LIKE @Value and   Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'')
               SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	where  Com.fn_OrganId(fldPrs_PersonalInfoId) =@OrganId
	ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	if (@fieldname=N'All')
SELECT TOP (@h) Pay.Pay_tblPersonalInfo.fldId, Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, Pay.Pay_tblPersonalInfo.fldTypeBimeId, Pay.Pay_tblPersonalInfo.fldShomareBime, 
                  Pay.Pay_tblPersonalInfo.fldBimeOmr, Pay.Pay_tblPersonalInfo.fldBimeTakmili, Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar, 
                  Pay.Pay_tblPersonalInfo.fldCostCenterId, Pay.Pay_tblPersonalInfo.fldMazad30Sal, Pay.Pay_tblPersonalInfo.fldPasAndaz, Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat, 
                  Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId, Pay.Pay_tblPersonalInfo.fldUserId, Pay.Pay_tblPersonalInfo.fldDate, Pay.Pay_tblPersonalInfo.fldDesc, 
                  Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee.fldCodemeli, 
                  Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblTypeBime.fldTitle AS fldTitleTypeBime, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblTabJobOfBime.fldJobDesc, 
                  Pay.Pay_tblPersonalInfo.fldJobeCode, CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                  CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) 
                  THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName, Pay.tblCostCenter.fldTitle AS fldTitleCostCenter, 
                  Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, 
                  Pay.Pay_tblPersonalInfo.fldHamsarKarmand, Pay.Pay_tblPersonalInfo.fldMoafDarman, Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS UserName, 
                  Prs.Prs_tblPersonalInfo.fldEsargariId,
                      (SELECT TOP (1) Com.tblStatus.fldId
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusId,
                      (SELECT TOP (1) tblStatus_1.fldTitle
                       FROM      Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                         Com.tblStatus AS tblStatus_1 ON tblPersonalStatus_1.fldStatusId = tblStatus_1.fldId
                       WHERE   (tblPersonalStatus_1.fldPayPersonalInfoId = Pay.Pay_tblPersonalInfo.fldId)
                       ORDER BY tblPersonalStatus_1.fldDate DESC) AS fldStatusTitle, Com.tblEmployee.fldName AS fldNameEmployee, Com.tblEmployee.fldFamily, 
                  Prs.Prs_tblPersonalInfo.fldEmployeeId
  ,(SELECT TOP(1) fldNoeEstekhdamId FROM Prs.tblHistoryNoeEstekhdam WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS fldNoeEstekhdamId
                  ,(SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId WHERE fldPrsPersonalInfoId=Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ORDER BY tblHistoryNoeEstekhdam.fldid desc) AS  fldNoeEstekhdamTitle,FORMAT(fldTarikhMazad30Sal,'####/##/##') as fldTarikhMazad30Sal 

FROM     Pay.Pay_tblPersonalInfo INNER JOIN
                  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                  Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                  Pay.tblInsuranceWorkshop ON Pay.Pay_tblPersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                  Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN
                  Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                  Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                  Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      ORDER BY tblEmployee.fldFamily,tblEmployee.fldName ASC
	
	
	COMMIT
GO
