SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEtelaatEydiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Id INT,
	@Year SMALLINT,
	@NobatePardakht TINYINT,
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblEtelaatEydi.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
ORDER BY Pay.tblEtelaatEydi.fldId desc

	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblEtelaatEydi.fldDesc LIKE @Value
ORDER BY Pay.tblEtelaatEydi.fldId desc


if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldPersonalId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
ORDER BY Pay.tblEtelaatEydi.fldId desc

if (@fieldname=N'CheckSave')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldPersonalId = @Value AND fldYear=@Year AND  fldNobatePardakht=@NobatePardakht
ORDER BY Pay.tblEtelaatEydi.fldId desc

if (@fieldname=N'CheckEdit')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE Pay.tblEtelaatEydi.fldId <> @Id AND fldPersonalId = @Value AND fldYear=@Year AND  fldNobatePardakht=@NobatePardakht
ORDER BY Pay.tblEtelaatEydi.fldId desc


	if (@fieldname=N'Mohasebe')
	SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE fldYear=@Year AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
    
    if (@fieldname=N'Mohasebe_Id')
	SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE  fldPersonalId=@Id and fldYear=@Year AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId

	if (@fieldname=N'fldName_Father_Mohasebe')
	SELECT     TOP (@h)* FROM (SELECT     Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE fldYear=@Year AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId )t
                      WHERE fldName_Father LIKE @Value
                      
    
	if (@fieldname=N'fldCodemeli_Mohasebe')
	SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE fldYear=@Year AND fldNobatePardakht=@NobatePardakht AND fldCodemeli LIKE @Value
                      AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                      
     
	if (@fieldname=N'fldSh_Personali_Mohasebe')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE fldYear=@Year AND fldNobatePardakht=@NobatePardakht  AND fldSh_Personali LIKE @Value     
                      AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId            
	
		if (@fieldname=N'ALL')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 

	if (@fieldname=N'fldPersonalId_Id')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE fldPersonalId=@id AND  Pay.tblEtelaatEydi.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
ORDER BY Pay.tblEtelaatEydi.fldId desc

	if (@fieldname=N'fldPersonalId_Year')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE fldPersonalId=@id AND  Pay.tblEtelaatEydi.fldYear LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
ORDER BY Pay.tblEtelaatEydi.fldId desc

	if (@fieldname=N'fldPersonalId_Kosurat')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE fldPersonalId=@id AND  Pay.tblEtelaatEydi.fldKosurat LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
ORDER BY Pay.tblEtelaatEydi.fldId desc

	if (@fieldname=N'fldPersonalId_DayCount')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE fldPersonalId=@id AND  Pay.tblEtelaatEydi.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
ORDER BY Pay.tblEtelaatEydi.fldId desc

	if (@fieldname=N'fldPersonalId_NobatePardakhtName')
SELECT     TOP (@h)* FROM(SELECT Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId)t
	WHERE fldPersonalId=@id AND  fldNobatePardakhtName = @Value  



	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblEtelaatEydi.fldId, Pay.tblEtelaatEydi.fldPersonalId, Pay.tblEtelaatEydi.fldYear, Pay.tblEtelaatEydi.fldDayCount, Pay.tblEtelaatEydi.fldKosurat, 
                      Pay.tblEtelaatEydi.fldNobatePardakht, Pay.tblEtelaatEydi.fldUserId, Pay.tblEtelaatEydi.fldDate, Pay.tblEtelaatEydi.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEtelaatEydi.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblEtelaatEydi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEtelaatEydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      where Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
ORDER BY Pay.tblEtelaatEydi.fldId desc

	COMMIT
GO
