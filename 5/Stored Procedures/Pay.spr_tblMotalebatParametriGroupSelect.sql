SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMotalebatParametriGroupSelect]
@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT
as
IF(@fieldname='fldTypeEstekhdamId')
SELECT    Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId,  tblEmployee.fldName, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId)AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali,a.fldTitle, Pay.Pay_tblPersonalInfo.fldId,a.fldNoeEstekhdamId,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
                     CROSS APPLY(SELECT TOP(1) Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId from Prs.tblHistoryNoeEstekhdam   INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                      where Prs.Prs_tblPersonalInfo.fldId = Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId
                      order BY Prs.tblHistoryNoeEstekhdam.fldTarikh DESC ,Prs.tblHistoryNoeEstekhdam.fldDate desc) a
                    WHERE --a.fldNoeEstekhdamId=[Com].fn_MaxPersonalTypeEstekhdam( Prs.Prs_tblPersonalInfo.fldId)AND
                       a.fldNoeEstekhdamId=@Value
							AND   Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
							AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
                    
IF(@fieldname='')
SELECT Pay.Pay_tblPersonalInfo.fldId AS fldPersonalInfoId,  tblEmployee.fldName, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId)AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali,a.fldTitle, Pay.Pay_tblPersonalInfo.fldId,a.fldNoeEstekhdamId,CAST(0 AS bit) AS fldChecked
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
                     CROSS APPLY(SELECT TOP(1) Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId from Prs.tblHistoryNoeEstekhdam   INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                      where Prs.Prs_tblPersonalInfo.fldId = Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId
                      order BY Prs.tblHistoryNoeEstekhdam.fldTarikh DESC ,Prs.tblHistoryNoeEstekhdam.fldDate desc) a
                    WHERE --a.fldNoeEstekhdamId=[Com].fn_MaxPersonalTypeEstekhdam( Prs.Prs_tblPersonalInfo.fldId)AND
							 Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 
							AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
							and exists (select * from pay.tblMotalebateParametri_Personal as m where m.fldPersonalId=Pay.Pay_tblPersonalInfo.fldId )

GO
