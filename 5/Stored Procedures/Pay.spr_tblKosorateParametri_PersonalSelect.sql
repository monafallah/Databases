SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosorateParametri_PersonalSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value1 NVARCHAR(50),
	@value2 NVARCHAR(50),
	@value3 NVARCHAR(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
	WHERE Pay.tblKosorateParametri_Personal.fldId = @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
	order by Pay.tblKosorateParametri_Personal.fldId desc

	if (@fieldname=N'CheckId')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
	WHERE Pay.tblKosorateParametri_Personal.fldId = @Value 
	
if (@fieldname=N'flddesc')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
	WHERE Pay.tblKosorateParametri_Personal.fldDesc = @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
	order by Pay.tblKosorateParametri_Personal.fldId desc

	if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
	WHERE Pay.tblKosorateParametri_Personal.fldPersonalId = @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
	order by Pay.tblKosorateParametri_Personal.fldId desc
	
	if (@fieldname=N'CheckPersonalId')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
	WHERE Pay.tblKosorateParametri_Personal.fldPersonalId = @Value 
	order by Pay.tblKosorateParametri_Personal.fldId desc
	
	if (@fieldname=N'CheckParametrId')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
	WHERE Pay.tblKosorateParametri_Personal.fldParametrId = @Value 
	
		if (@fieldname=N'CheckPersonal')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
                      WHERE fldPersonalId=@value AND fldParametrId=@value1 AND fldMablagh=@value2 AND fldTarikhePardakht=@value3
	
	if (@fieldname=N'RealoadDeactive')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
                      WHERE tblKosorateParametri_Personal.fldStatus=@Value and  fldParametrId=@value1 AND fldMablagh=@value2 AND fldTarikhePardakht=@value3
	

	if (@fieldname=N'ALL')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
order by Pay.tblKosorateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_Id')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
	WHERE  fldPersonalId=@value1 AND   Pay.tblKosorateParametri_Personal.fldId = @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
	order by Pay.tblKosorateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_ParamTitle')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
	WHERE  fldPersonalId=@value1 AND   Pay.tblParametrs.fldTitle like @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
order by Pay.tblKosorateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_Tedad')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
	WHERE  fldPersonalId=@value1 AND   Pay.tblKosorateParametri_Personal.fldTedad LIKE @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId


if (@fieldname=N'fldPersonalId_TarikhePardakht')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
	WHERE  fldPersonalId=@value1 AND   Pay.tblKosorateParametri_Personal.fldTarikhePardakht LIKE @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
	order by Pay.tblKosorateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_Mablagh')
SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
	WHERE  fldPersonalId=@value1 AND   Pay.tblKosorateParametri_Personal.fldMablagh LIKE @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
order by Pay.tblKosorateParametri_Personal.fldId desc

if (@fieldname=N'fldPersonalId_statusName')
SELECT     TOP (@h) *FROM (SELECT Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                      Pay.tblKosorateParametri_Personal.fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, Pay.tblKosorateParametri_Personal.fldMondeFish, 
                      Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, Pay.tblKosorateParametri_Personal.fldStatus, 
                      Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, Pay.tblKosorateParametri_Personal.fldDesc, 
                      Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) 
                      THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) 
                      AS fldName_Father, tblEmployee.fldCodemeli, Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId           
                      WHERE Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId)t
	WHERE  fldPersonalId=@value1 AND fldstatusName LIKE @Value 
	order by fldId desc

	if (@fieldname=N'')
	SELECT     TOP (@h) Pay.tblKosorateParametri_Personal.fldId, Pay.tblKosorateParametri_Personal.fldPersonalId, Pay.tblKosorateParametri_Personal.fldParametrId, 
                      Pay.tblKosorateParametri_Personal.fldNoePardakht, Pay.tblKosorateParametri_Personal.fldMablagh, Pay.tblKosorateParametri_Personal.fldTedad, 
                       fldTarikhePardakht, Pay.tblKosorateParametri_Personal.fldSumFish, 
                      Pay.tblKosorateParametri_Personal.fldMondeFish, Pay.tblKosorateParametri_Personal.fldSumPardakhtiGHabl, Pay.tblKosorateParametri_Personal.fldMondeGHabl, 
                      Pay.tblKosorateParametri_Personal.fldStatus, Pay.tblKosorateParametri_Personal.fldDateDeactive, Pay.tblKosorateParametri_Personal.fldUserId, 
                      Pay.tblKosorateParametri_Personal.fldDesc, Pay.tblKosorateParametri_Personal.fldDate, CASE WHEN (fldNoePardakht = 0) 
                      THEN N'تعدادی' ELSE N'دائمی' END AS fldNoePardakhtName, CASE WHEN (tblKosorateParametri_Personal.fldStatus = 0) THEN N'غیرفعال' ELSE N'فعال' END AS fldstatusName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Father, tblEmployee.fldCodemeli, 
                      Pay.tblParametrs.fldTitle AS fldParamTitle
FROM         Pay.tblKosorateParametri_Personal INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKosorateParametri_Personal.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblParametrs ON Pay.tblKosorateParametri_Personal.fldParametrId = Pay.tblParametrs.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                      where Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
order by Pay.tblKosorateParametri_Personal.fldId desc

	COMMIT
GO
