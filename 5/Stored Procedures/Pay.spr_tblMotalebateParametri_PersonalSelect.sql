SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMotalebateParametri_PersonalSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value1 NVARCHAR(50),
	@value2 NVARCHAR(50),
	@value3 NVARCHAR(50),
	@OragnId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblMotalebateParametri_Personal.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId
	order by Pay.tblMotalebateParametri_Personal.fldId desc

	if (@fieldname=N'CheckId')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblMotalebateParametri_Personal.fldId = @Value 
	

	if (@fieldname=N'fldPersonalId')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.Pay_tblPersonalInfo.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId
		order by Pay.tblMotalebateParametri_Personal.fldId desc
	
	if (@fieldname=N'fldParametrId')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus= 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblMotalebateParametri_Personal.fldParametrId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId
	
	if (@fieldname=N'checkParametrId')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblMotalebateParametri_Personal.fldParametrId = @Value
	
	
		if (@fieldname=N'CheckPersonal')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                          WHERE fldPersonalId=@value AND fldParametrId=@value1 AND fldMablagh=@value2 AND fldTarikhPardakht=@value3
						AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId

	if (@fieldname=N'CheckPersonalId')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                          WHERE fldPersonalId=@value 
	
if (@fieldname=N'RealoadDeactive')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                          WHERE tblMotalebateParametri_Personal.fldStatus=@Value and  fldParametrId=@value1 AND fldMablagh=@value2 AND fldTarikhPardakht=@value3

		if (@fieldname=N'All')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
					  	order by Pay.tblMotalebateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_Id')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  fldPersonalId = @value1 AND Pay.tblMotalebateParametri_Personal.fldId = @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId

if (@fieldname=N'fldPersonalId_ParamTitle')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  fldPersonalId = @value1 AND Pay.tblParametrs.fldTitle LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId
		order by Pay.tblMotalebateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_Tedad')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  fldPersonalId = @value1 AND Pay.tblMotalebateParametri_Personal.fldTedad LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId
		order by Pay.tblMotalebateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_Mablagh')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  fldPersonalId = @value1 AND Pay.tblMotalebateParametri_Personal.fldMablagh LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId
		order by Pay.tblMotalebateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_TarikhPardakht')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  fldPersonalId = @value1 AND Pay.tblMotalebateParametri_Personal.fldTarikhPardakht LIKE @Value AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId
		order by Pay.tblMotalebateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_MashmoleMaliytName')
SELECT   TOP(@h) * FROM (SELECT  Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId)t
	WHERE  fldPersonalId = @value1 AND fldMashmoleMaliytName LIKE @Value  
		order by fldId desc

if (@fieldname=N'fldPersonalId_MashmoleBimeName')
SELECT   TOP(@h) * FROM (SELECT  Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId)t
	WHERE  fldPersonalId = @value1 AND fldMashmoleBimeName LIKE @Value
		order by fldId desc

if (@fieldname=N'fldPersonalId_NoePardakhtName')
SELECT   TOP(@h) * FROM (SELECT  Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId)t
	WHERE  fldPersonalId = @value1 AND fldNoePardakhtName LIKE @Value
		order by fldId desc

	if (@fieldname=N'fldDesc')
SELECT   TOP(@h) * FROM (SELECT  Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId)t
	WHERE  t.fldDesc LIKE @Value
		order by fldId desc

	if (@fieldname=N'')
SELECT   TOP(@h)   Pay.tblMotalebateParametri_Personal.fldId, Pay.tblMotalebateParametri_Personal.fldPersonalId, Pay.tblMotalebateParametri_Personal.fldParametrId, 
                      Pay.tblMotalebateParametri_Personal.fldNoePardakht, Pay.tblMotalebateParametri_Personal.fldMablagh, Pay.tblMotalebateParametri_Personal.fldTedad, 
                      Pay.tblMotalebateParametri_Personal.fldTarikhPardakht, Pay.tblMotalebateParametri_Personal.fldMashmoleBime, 
                      Pay.tblMotalebateParametri_Personal.fldMashmoleMaliyat, Pay.tblMotalebateParametri_Personal.fldStatus, Pay.tblMotalebateParametri_Personal.fldDateDeactive, 
                      Pay.tblMotalebateParametri_Personal.fldUserId, Pay.tblMotalebateParametri_Personal.fldDesc, Pay.tblMotalebateParametri_Personal.fldDate, 
                      CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (fldMashmoleBime = 0) 
                      THEN N'خیر' ELSE N'بلی' END AS fldMashmoleBimeName, CASE WHEN (fldMashmoleMaliyat = 0) THEN N'خیر' ELSE N'بلی' END AS fldMashmoleMaliytName, 
                      CASE WHEN (Pay.tblMotalebateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldStatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(tblEmployee.fldId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle,fldMazayaMashmool, CASE WHEN (fldMazayaMashmool = 0)THEN N'خیر' ELSE N'بلی' END AS fldMazayaMashmoolName
FROM         Pay.tblMotalebateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMotalebateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblMotalebateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
					where  Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId) =@OragnId
						order by Pay.tblMotalebateParametri_Personal.fldId desc
	COMMIT
GO
