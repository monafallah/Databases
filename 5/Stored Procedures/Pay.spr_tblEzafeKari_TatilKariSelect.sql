SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEzafeKari_TatilKariSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Id INT,
	@Year SMALLINT,
	@Month TINYINT,
	@NobatePardakht TINYINT,
	@Type TINYINT,
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblEzafeKari_TatilKari.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
	if (@fieldname=N'CheckId')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblEzafeKari_TatilKari.fldId = @Value 
	ORDER BY fldFamily,fldName ASC
	
		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.tblEzafeKari_TatilKari.fldDesc LIKE @Value 
	ORDER BY fldFamily,fldName ASC
	

		if (@fieldname=N'CheckPersonalId')
	SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.Pay_tblPersonalInfo.fldId = @Value AND fldType=@Type
	
	
	if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.Pay_tblPersonalInfo.fldId = @Value AND fldType=@Type AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
	if (@fieldname=N'Mohasebe')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht AND fldType=@Type AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC

	if (@fieldname=N'Mohasebe_Id')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE fldPersonalId=@Id and
	fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht AND fldType=@Type 
	

	
		if (@fieldname=N'fldName_Father_Mohasebe')
	SELECT * FROM (SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht   AND fldType=@Type AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC)t
	WHERE  t.fldName_Father LIKE @Value
	
	
	
	
		if (@fieldname=N'fldCodemeli_Mohasebe')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht AND tblEmployee.fldCodemeli LIKE @Value  AND fldType=@Type
	AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
	
	
		if (@fieldname=N'fldSh_Personali_Mohasebe')
	SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht AND fldSh_Personali LIKE @Value  AND fldType=@Type
	AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
	
	
		if (@fieldname=N'fldHasMaliyatName_Mohasebe')
	SELECT    * FROM (SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht  AND fldType=@Type AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC)t
	WHERE fldHasBimeName LIKE @Value
	
	
	
	
		if (@fieldname=N'fldHasMaliyatName_Mohasebe')
	SELECT    * FROM (SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldYear=@Year AND fldMonth =@Month AND fldNobatePardakht=@NobatePardakht  AND fldType=@Type AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
		ORDER BY fldFamily,fldName ASC)t
	WHERE fldHasMaliyatName LIKE @Value

	
	
	
	
	if (@fieldname=N'CheckSave')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  Pay.Pay_tblPersonalInfo.fldId = @Value AND fldType=@Type AND fldYear=@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht 
	
	ORDER BY fldFamily,fldName ASC
	
	if (@fieldname=N'CheckEdit')
	SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE Pay.tblEzafeKari_TatilKari.fldId <> @Id AND  Pay.Pay_tblPersonalInfo.fldId = @Value AND fldType=@Type AND fldYear=@Year AND fldMonth=@Month AND fldNobatePardakht=@NobatePardakht
	ORDER BY fldFamily,fldName ASC
	
		if (@fieldname=N'ALL')
	SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	
		if (@fieldname=N'fldPersonalId_Id')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldPersonalId=@Id AND Pay.tblEzafeKari_TatilKari.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
			if (@fieldname=N'fldPersonalId_Year')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldPersonalId=@Id AND Pay.tblEzafeKari_TatilKari.fldYear LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
			if (@fieldname=N'fldPersonalId_Count')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
	WHERE  fldPersonalId=@Id AND Pay.tblEzafeKari_TatilKari.fldCount like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	
			if (@fieldname=N'fldPersonalId_NobatePardakhtName')
SELECT     TOP (@h)* FROM (SELECT Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId)t
	WHERE  fldPersonalId=@Id AND fldNobatePardakhtName LIKE @Value 
	
	
			if (@fieldname=N'fldPersonalId_HasBimeName')
SELECT     TOP (@h)* FROM (SELECT Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId)t
	WHERE  fldPersonalId=@Id AND fldHasBimeName LIKE @Value  

	
			if (@fieldname=N'fldPersonalId_HasMaliyatName')
SELECT     TOP (@h) * FROM (SELECT Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId)t
	WHERE  fldPersonalId=@Id AND fldHasMaliyatName LIKE @Value  

	
	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblEzafeKari_TatilKari.fldId, Pay.tblEzafeKari_TatilKari.fldPersonalId, Pay.tblEzafeKari_TatilKari.fldYear, Pay.tblEzafeKari_TatilKari.fldMonth, 
                      Pay.tblEzafeKari_TatilKari.fldNobatePardakht, Pay.tblEzafeKari_TatilKari.fldCount, Pay.tblEzafeKari_TatilKari.fldType, Pay.tblEzafeKari_TatilKari.fldUserId, 
                      Pay.tblEzafeKari_TatilKari.fldDate, Pay.tblEzafeKari_TatilKari.fldDesc, 
                      tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, tblEmployee.fldCodemeli, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_nobatePardakht(Pay.tblEzafeKari_TatilKari.fldNobatePardakht) AS fldNobatePardakhtName, 
                      Com.fn_month(Pay.tblEzafeKari_TatilKari.fldMonth) AS fldMonthName, Pay.tblEzafeKari_TatilKari.fldHasBime, Pay.tblEzafeKari_TatilKari.fldHasMaliyat, 
                      CASE WHEN fldHasBime = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasBimeName, 
                      CASE WHEN fldHasMaliyat = 1 THEN N' دارد' ELSE N'ندارد' END AS fldHasMaliyatName, Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) 
                      AS fldOrganId,fldFlag
FROM         Pay.tblEzafeKari_TatilKari INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
	ORDER BY fldFamily,fldName ASC
	COMMIT
GO
