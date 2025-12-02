SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSayerPardakhtsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Id INT,
	@Year SMALLINT,
	@Month TINYINT,
	@NobatePardakht TINYINT,
	@MarhalePardakht TINYINT,
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value= Com.fn_TextNormalize( @Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblSayerPardakhts.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldFamily,fldName

if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  Pay.tblSayerPardakhts.fldDesc LIKE @Value
ORDER BY fldFamily,fldName


if (@fieldname=N'fldTitle')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldTitle  like @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
	ORDER BY fldFamily,fldName
	
	
		if (@fieldname=N'CheckPersonalId')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  (fldPersonalId) = ( @Value) 
		ORDER BY fldFamily,fldName
	
	if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE  (fldPersonalId) = ( @Value) AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
	ORDER BY fldYear desc,fldMonth desc
	
	if (@fieldname=N'CheckSave')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE  (fldPersonalId) = ( @Value) AND fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatePardakht AND fldMarhalePardakht=@MarhalePardakht
                   
ORDER BY fldFamily,fldName

if (@fieldname=N'CheckEdit')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE Pay.tblSayerPardakhts.fldId <> @Id and  (fldPersonalId) = ( @Value) AND fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatePardakht AND fldMarhalePardakht=@MarhalePardakht
                      
ORDER BY fldFamily,fldName

if (@fieldname=N'CheckHasData')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatePardakht and fldMarhalePardakht=@MarhalePardakht and Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldFamily,fldName

if (@fieldname=N'CheckPardakhtGroup')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatePardakht and fldMarhalePardakht=@MarhalePardakht and Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
						and fldFlag=1

if (@fieldname=N'CheckPardakht')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE fldPersonalId=@Value and  fldYear=@Year AND fldMonth=@Month AND fldNobatePardakt=@NobatePardakht and fldMarhalePardakht=@MarhalePardakht and Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
						and fldFlag=1


if (@fieldname=N'fldYear_Month')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      	WHERE fldYear=@Year AND fldMonth=@Month AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldFamily,fldName

	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
                      ORDER BY fldFamily,fldName
                      
 	if (@fieldname=N'fldPersonalId_Id')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id AND    Pay.tblSayerPardakhts.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldYear desc , fldMonth desc

 	if (@fieldname=N'fldPersonalId_Year')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id AND    Pay.tblSayerPardakhts.fldYear LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldFamily,fldName

 	if (@fieldname=N'fldPersonalId_Title')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id AND    Pay.tblSayerPardakhts.fldTitle LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldFamily,fldName

 	if (@fieldname=N'fldPersonalId_Amount')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id AND    Pay.tblSayerPardakhts.fldAmount LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldFamily,fldName

 	if (@fieldname=N'fldPersonalId_Maliyat')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id AND    Pay.tblSayerPardakhts.fldMaliyat LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldFamily,fldName

 	if (@fieldname=N'fldPersonalId_KhalesPardakhti')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
	WHERE fldPersonalId=@Id AND    Pay.tblSayerPardakhts.fldKhalesPardakhti LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId
ORDER BY fldFamily,fldName

 	if (@fieldname=N'fldPersonalId_MarhalePardakhtName')
SELECT     TOP (@h) * FROM (SELECT Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId)t
	WHERE fldPersonalId=@Id AND    fldMarhalePardakhtName LIKE @Value 
 
 	if (@fieldname=N'fldPersonalId_MonthName')
SELECT     TOP (@h) * FROM (SELECT Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId)t
	WHERE fldPersonalId=@Id AND    fldMonthName LIKE @Value 

 	if (@fieldname=N'fldPersonalId_NobatePardaktName')
SELECT     TOP (@h)* FROM(SELECT Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldid) =@OrganId)t
	WHERE fldPersonalId=@Id AND    fldNobatePardaktName LIKE @Value 

                      
  if (@fieldname=N'ALL')
SELECT     TOP (@h) Pay.tblSayerPardakhts.fldId, Pay.tblSayerPardakhts.fldPersonalId, Pay.tblSayerPardakhts.fldYear, Pay.tblSayerPardakhts.fldMonth, 
                      Pay.tblSayerPardakhts.fldAmount, Pay.tblSayerPardakhts.fldTitle, Pay.tblSayerPardakhts.fldNobatePardakt, Pay.tblSayerPardakhts.fldMarhalePardakht, 
                      Pay.tblSayerPardakhts.fldUserId, Pay.tblSayerPardakhts.fldDate, Pay.tblSayerPardakhts.fldDesc, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      Com.tblEmployee.fldId AS fldEmployeeId, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_Father, Com.tblEmployee.fldCodemeli, 
                      Com.fn_nobatePardakht(Pay.tblSayerPardakhts.fldNobatePardakt) AS fldNobatePardaktName, CASE WHEN (fldMarhalePardakht = 1) 
                      THEN N'یک' WHEN (fldMarhalePardakht = 2) THEN N'دو' WHEN (fldMarhalePardakht = 3) THEN N'سه' WHEN (fldMarhalePardakht = 4) 
                      THEN N'چهار' WHEN (fldMarhalePardakht = 5) THEN N'پنج' END AS fldMarhalePardakhtName, Com.fn_month(Pay.tblSayerPardakhts.fldMonth) AS fldMonthName, 
                      Pay.tblSayerPardakhts.fldHasMaliyat, Pay.tblSayerPardakhts.fldMaliyat, Pay.tblSayerPardakhts.fldKhalesPardakhti, Pay.Pay_tblPersonalInfo.fldJobeCode,fldFlag
					  ,fldMostamar,CASE WHEN fldMostamar = 1 THEN N'مستمر' ELSE N'غیر مستمر' END AS fldNameNoeMostamar
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                         ORDER BY fldFamily,fldName
	
	COMMIT
GO
