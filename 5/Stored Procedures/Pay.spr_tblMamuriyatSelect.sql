SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMamuriyatSelect] 
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
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblMamuriyat.fldId = @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblMamuriyat.fldDesc LIKE @Value 
	ORDER BY fldFamily,fldName ASC
	
	
		if (@fieldname=N'Mohasebe')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
	if (@fieldname=N'Mohasebe_Id')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE   fldPersonalId=@Id and fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht 


			if (@fieldname=N'fldName_Father_Mohasebe')
SELECT   TOP(@h) * FROM(SELECT     Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	)t
	WHERE fldName_Father LIKE @Value 
	
			if (@fieldname=N'fldSh_Personali_Mohasebe')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht  AND fldSh_Personali LIKE @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
	
			if (@fieldname=N'fldCodemeli_Mohasebe')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht AND fldCodemeli LIKE @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
	if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblMamuriyat.fldPersonalId= @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
		if (@fieldname=N'CheckPersonalId')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblMamuriyat.fldPersonalId= @Value

if (@fieldname=N'CheckSave')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  (fldPersonalId) = ( @Value) AND fldYear=@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht
	ORDER BY fldFamily,fldName ASC
	
	if (@fieldname=N'CheckEdit')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblMamuriyat.fldId <> @Id and  (fldPersonalId) = ( @Value) AND fldYear=@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht
	ORDER BY fldFamily,fldName ASC
	
		if (@fieldname=N'ALL')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 

	if (@fieldname=N'fldPersonalId_Id')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblMamuriyat.fldPersonalId= @Id and Pay.tblMamuriyat.fldId like @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
	if (@fieldname=N'fldPersonalId_Year')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblMamuriyat.fldPersonalId= @Id and Pay.tblMamuriyat.fldYear like @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
		if (@fieldname=N'fldPersonalId_MonthName')
SELECT     TOP (@h)* FROM (SELECT Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId )t
	WHERE  fldPersonalId= @Id and fldMonthName like @Value  

	
	if (@fieldname=N'fldPersonalId_NobatePardakht')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblMamuriyat.fldPersonalId= @Id and Pay.tblMamuriyat.fldNobatePardakht like @Value AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId
	ORDER BY fldFamily,fldName ASC
		
	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblMamuriyat.fldId, Pay.tblMamuriyat.fldPersonalId, Pay.tblMamuriyat.fldYear, Pay.tblMamuriyat.fldMonth, Pay.tblMamuriyat.fldNobatePardakht, 
                      Pay.tblMamuriyat.fldBaBeytute, Pay.tblMamuriyat.fldBeduneBeytute, Pay.tblMamuriyat.fldBa10, Pay.tblMamuriyat.fldBa20, Pay.tblMamuriyat.fldBa30, 
                      Pay.tblMamuriyat.fldBe10, Pay.tblMamuriyat.fldBe20, Pay.tblMamuriyat.fldBe30, Pay.tblMamuriyat.fldUserId, Pay.tblMamuriyat.fldDate, Pay.tblMamuriyat.fldDesc, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName_Father, 
                      tblEmployee.fldCodemeli, Com.fn_nobatePardakht(Pay.tblMamuriyat.fldNobatePardakht) AS fldNobatePardakhtName, Com.fn_month(Pay.tblMamuriyat.fldMonth) 
                      AS fldMonthName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS fldOrganId,fldFlag
FROM         Pay.tblMamuriyat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE  Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId                      
	ORDER BY fldFamily,fldName ASC
	COMMIT
GO
