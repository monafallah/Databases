SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMorakhasiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Id INT,
	@Year SMALLINT,
	@Month TINYINT,
	@NobatePardakht TINYINT,
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblMorakhasi.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 

	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblMorakhasi.fldDesc LIKE @Value 
	order BY fldFamily,fldName 

if (@fieldname=N'CheckSave')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE (fldPersonalId) = ( @Value) AND fldYear=@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht 
	order BY fldFamily,fldName
	
	if (@fieldname=N'CheckEdit')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE Pay.tblMorakhasi.fldId <> @Id and (fldPersonalId) = ( @Value) AND fldYear=@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht 
	order BY fldFamily,fldName
	
	if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE (fldPersonalId) = ( @Value) AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 
	
	if (@fieldname=N'CheckPersonalId')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE (fldPersonalId) = ( @Value) 
	order BY fldFamily,fldName 
	
	
		if (@fieldname=N'Mohasebe')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 
	
	if (@fieldname=N'Mohasebe_Id')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldPersonalId=@Id and fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht 


			if (@fieldname=N'fldName_Father_Mohasebe')
SELECT  TOP(@h)   * FROM (SELECT    Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	)t
		WHERE 	fldName_Father like @value
	
			if (@fieldname=N'fldSh_Personali_Mohasebe')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht AND fldSh_Personali LIKE @value
                      AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 

	
			if (@fieldname=N'fldCodemeli_Mohasebe')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear =@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht AND fldCodemeli LIKE @value
                     AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 
	
	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      where  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName
	
	if (@fieldname=N'fldPersonalId_Id')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldPersonalId=@id and Pay.tblMorakhasi.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 	
	
		if (@fieldname=N'fldPersonalId_Year')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldPersonalId=@id and Pay.tblMorakhasi.fldYear LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 	
	
	
		if (@fieldname=N'fldPersonalId_Tedad')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldPersonalId=@id and Pay.tblMorakhasi.fldTedad LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 	
	
	
		if (@fieldname=N'fldPersonalId_SalAkharinHokm')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldPersonalId=@id and Pay.tblMorakhasi.fldSalAkharinHokm LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId
	order BY fldFamily,fldName 	
	
	
		if (@fieldname=N'fldPersonalId_NobatePardakhtName')
SELECT     TOP (@h)* FROM (SELECT Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId)t
	WHERE  fldPersonalId=@id and fldNobatePardakhtName LIKE @Value  
		
	
		if (@fieldname=N'fldPersonalId_MonthName')
SELECT     TOP (@h)* FROM (SELECT Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OrganId)t
	WHERE  fldPersonalId=@id and fldMonthName LIKE @Value  

	
	
	if (@fieldname=N'ALL')
SELECT     TOP (@h) Pay.tblMorakhasi.fldId, Pay.tblMorakhasi.fldPersonalId, Pay.tblMorakhasi.fldYear, Pay.tblMorakhasi.fldMonth, Pay.tblMorakhasi.fldNobatePardakht, 
                      Pay.tblMorakhasi.fldSalAkharinHokm, Pay.tblMorakhasi.fldTedad, Pay.tblMorakhasi.fldUserId, Pay.tblMorakhasi.fldDate, Pay.tblMorakhasi.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldId AS fldEmployeeId, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblMorakhasi.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMorakhasi.fldMonth) AS fldMonthName, 
                      Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMorakhasi INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMorakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId

	
	COMMIT
GO
