SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_HistoryAfradTahtePoshesheBimeTakmily](@PersonalId INT,@organid int)
as
SELECT     cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldId, cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldPersonalId, 
                      cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldTedadAsli, cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldTedadTakafol60Sal, 
                      cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldTedadTakafol70Sal, cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldGHarardadBimeId, 
                      cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldUserId, cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldDesc, 
                      dbo.Fn_AssembelyMiladiToShamsi(cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldDate) as fldDate, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee_Detail.fldFatherName, 
                      Pay.tblGHarardadBime.fldNameBime,fldCodemeli,fldSh_Personali
FROM         cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT INNER JOIN
                      Pay.Pay_tblPersonalInfo ON cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId AND 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId AND Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId AND 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Pay.tblGHarardadBime ON cdc.Pay_tblAfradeTahtePoshesheBimeTakmily_CT.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId
where fldPersonalId=@PersonalId AND [__$operation]=3  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
UNION
SELECT        Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, 
                         Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId,  Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli,  Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                          Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal,  Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId,  Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, 
                          Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc,  dbo.Fn_AssembelyMiladiToShamsi(Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate)as fldDate, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                         Com.tblEmployee_Detail.fldFatherName,Pay.tblGHarardadBime.fldNameBime,fldCodemeli,fldSh_Personali
FROM           Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                         Pay.Pay_tblPersonalInfo ON  Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId AND Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId AND 
                         Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId AND Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Pay.tblGHarardadBime ON  Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId
where fldPersonalId=@PersonalId  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
GO
