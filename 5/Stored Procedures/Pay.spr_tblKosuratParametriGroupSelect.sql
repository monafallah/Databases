SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosuratParametriGroupSelect]
@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT
as
IF(@fieldname='fldTypeEstekhdamId')
SELECT   Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId,fldPrs_PersonalInfoId,   tblEmployee.fldName, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId)AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, h.fldTitle, Pay.Pay_tblPersonalInfo.fldId, h.fldNoeEstekhdamId,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
					  cross apply(select top(1) Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId from Prs.tblHistoryNoeEstekhdam  INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
					  where  Prs.Prs_tblPersonalInfo.fldId = Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId
					  order by tblHistoryNoeEstekhdam.fldTarikh desc ,Prs.tblHistoryNoeEstekhdam.fldDate desc)h
                      WHERE --Com.tblAnvaEstekhdam.fldId=[Com].fn_MaxPersonalTypeEstekhdam( Prs.Prs_tblPersonalInfo.fldId)AND
					  h.fldNoeEstekhdamId=@Value
							AND   Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 
							AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                    
IF(@fieldname='')
SELECT   Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId,fldPrs_PersonalInfoId,   tblEmployee.fldName, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId)AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, h.fldTitle, Pay.Pay_tblPersonalInfo.fldId, h.fldNoeEstekhdamId,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
					  cross apply(select top(1) Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId from Prs.tblHistoryNoeEstekhdam  INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
					  where  Prs.Prs_tblPersonalInfo.fldId = Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId
					  order by tblHistoryNoeEstekhdam.fldTarikh desc ,Prs.tblHistoryNoeEstekhdam.fldDate desc)h
                      WHERE --Com.tblAnvaEstekhdam.fldId=[Com].fn_MaxPersonalTypeEstekhdam( Prs.Prs_tblPersonalInfo.fldId)AND
							   Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
							AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
GO
