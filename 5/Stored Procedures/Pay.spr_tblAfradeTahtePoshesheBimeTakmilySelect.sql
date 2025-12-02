SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblAfradeTahtePoshesheBimeTakmilySelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@PersonalId int,
	@sal smallint,
	@mah tinyint,
	@nobat tinyint,

	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                     	WHERE Pay.tblAfradeTahtePoshesheBimeTakmily.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	order by fldFamily ,fldName 
	
		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                     	WHERE Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc LIKE @Value 
	order by fldFamily ,fldName 
	
	if (@fieldname=N'CheckPersonalId')
SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = @Value 

	if (@fieldname=N'fldPersonalId')
	SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
		order by Pay.tblAfradeTahtePoshesheBimeTakmily.fldId desc
	
	if (@fieldname=N'fldGHarardadBimeId_PersonalId')
	SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = @PersonalId AND Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = @Value
						AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER by fldFamily ,fldName 
	
		if (@fieldname=N'CheckGHarardadBimeId_PersonalId')
	SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = @PersonalId AND Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = @Value
						
	ORDER by fldFamily ,fldName 
	
	
	
	if (@fieldname=N'fldGHarardadBimeId')
	SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = @Value
						AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
		order by Pay.tblAfradeTahtePoshesheBimeTakmily.fldId desc

	if (@fieldname=N'CheckGHarardadBimeId')
	SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = @Value
	ORDER by fldFamily ,fldName 

	if (@fieldname=N'')
	SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                  where Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                  ORDER by fldFamily ,fldName 


	if (@fieldname=N'BimeAsli')
	
	SELECT     TOP (@h) Pay.tblAfradeTahtePoshesheBimeTakmily.fldId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadAsli, Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol60Sal, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldTedadTakafol70Sal, Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId, 
                      Pay.tblAfradeTahtePoshesheBimeTakmily.fldUserId, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDesc, Pay.tblAfradeTahtePoshesheBimeTakmily.fldDate, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblGHarardadBime.fldNameBime,fldTedadBedonePoshesh
FROM         Pay.tblAfradeTahtePoshesheBimeTakmily INNER JOIN
                      Pay.tblGHarardadBime ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldGHarardadBimeId = Pay.tblGHarardadBime.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblAfradeTahtePoshesheBimeTakmily.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  inner join pay.tblKarKardeMahane k on k.fldPersonalId=Pay_tblPersonalInfo.fldid
                  where Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId and fldTedadAsli<0  and fldYear=@sal
				  and fldMah =@mah  and fldNobatePardakht=@nobat and (tblAfradeTahtePoshesheBimeTakmily.fldPersonalId=@PersonalId or @PersonalId=0) 
                  ORDER by fldFamily ,fldName 


	COMMIT
GO
