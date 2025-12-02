SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblVamSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
		set @Value= Com.fn_TextNormalize (@Value)
	if (@fieldname=N'fldId')
	SELECT  TOP (@h) Pay.tblVam.fldId, Pay.tblVam.fldPersonalId,  fldTarikhDaryaft, Pay.tblVam.fldTypeVam, CASE WHEN (fldTypeVam = 1) 
               THEN N'کوتاه مدت' WHEN (fldTypeVam = 2) THEN N'بلند مدت' WHEN (fldTypeVam = 3) THEN N'مسکن' END AS fldTypeVamName, Pay.tblVam.fldMablaghVam, 
              Pay.tblVam.fldStartDate, Pay.tblVam.fldCount, Pay.tblVam.fldMablagh, Pay.tblVam.fldMandeVam, Pay.tblVam.fldStatus, Pay.tblVam.fldUserId, 
               Pay.tblVam.fldDate, Pay.tblVam.fldDesc,Com.fn_FamilyEmployee ( Prs.Prs_tblPersonalInfo.fldEmployeeId) as fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
			   ,CASE WHEN(tblVam.fldStatus=0) THEN N'تسویه شده' ELSE N'تسویه نشده' END AS fldStatusName
			   FROM         Pay.tblVam INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblVam.fldId = @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId

	if (@fieldname=N'CheckCalc')
	SELECT  TOP (@h) Pay.tblVam.fldId, Pay.tblVam.fldPersonalId,  fldTarikhDaryaft, Pay.tblVam.fldTypeVam, CASE WHEN (fldTypeVam = 1) 
               THEN N'کوتاه مدت' WHEN (fldTypeVam = 2) THEN N'بلند مدت' WHEN (fldTypeVam = 3) THEN N'مسکن' END AS fldTypeVamName, Pay.tblVam.fldMablaghVam, 
              Pay.tblVam.fldStartDate, Pay.tblVam.fldCount, Pay.tblVam.fldMablagh, Pay.tblVam.fldMandeVam, Pay.tblVam.fldStatus, Pay.tblVam.fldUserId, 
               Pay.tblVam.fldDate, Pay.tblVam.fldDesc,Com.fn_FamilyEmployee ( Prs.Prs_tblPersonalInfo.fldEmployeeId) as fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
			   ,CASE WHEN(tblVam.fldStatus=0) THEN N'تسویه شده' ELSE N'تسویه نشده' END AS fldStatusName
			   FROM         Pay.tblVam INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId inner join
					  pay.tblMohasebat_PersonalInfo as p on p.fldVamId=tblVam.fldId
	WHERE  Pay.tblVam.fldId = @Value 

	if (@fieldname=N'flddesc')
	SELECT  TOP (@h) Pay.tblVam.fldId, Pay.tblVam.fldPersonalId,  fldTarikhDaryaft, Pay.tblVam.fldTypeVam, CASE WHEN (fldTypeVam = 1) 
               THEN N'کوتاه مدت' WHEN (fldTypeVam = 2) THEN N'بلند مدت' WHEN (fldTypeVam = 3) THEN N'مسکن' END AS fldTypeVamName, Pay.tblVam.fldMablaghVam, 
              Pay.tblVam.fldStartDate, Pay.tblVam.fldCount, Pay.tblVam.fldMablagh, Pay.tblVam.fldMandeVam, Pay.tblVam.fldStatus, Pay.tblVam.fldUserId, 
               Pay.tblVam.fldDate, Pay.tblVam.fldDesc,Com.fn_FamilyEmployee ( Prs.Prs_tblPersonalInfo.fldEmployeeId) as fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
			   ,CASE WHEN(tblVam.fldStatus=0) THEN N'تسویه شده' ELSE N'تسویه نشده' END AS fldStatusName
			   FROM         Pay.tblVam INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblVam.flddesc = @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
                        order by Pay.tblVam.fldId desc

	if (@fieldname=N'PersonalId')
	SELECT  TOP (@h) Pay.tblVam.fldId, Pay.tblVam.fldPersonalId,  fldTarikhDaryaft, Pay.tblVam.fldTypeVam, CASE WHEN (fldTypeVam = 1) 
               THEN N'کوتاه مدت' WHEN (fldTypeVam = 2) THEN N'بلند مدت' WHEN (fldTypeVam = 3) THEN N'مسکن' END AS fldTypeVamName, Pay.tblVam.fldMablaghVam, 
              Pay.tblVam.fldStartDate, Pay.tblVam.fldCount, Pay.tblVam.fldMablagh, Pay.tblVam.fldMandeVam, Pay.tblVam.fldStatus, Pay.tblVam.fldUserId, 
               Pay.tblVam.fldDate, Pay.tblVam.fldDesc,Com.fn_FamilyEmployee ( Prs.Prs_tblPersonalInfo.fldEmployeeId) as fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
			   ,CASE WHEN(tblVam.fldStatus=0) THEN N'تسویه شده' ELSE N'تسویه نشده' END AS fldStatusName
			   FROM         Pay.tblVam INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblVam.fldPersonalId = @Value AND Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
                        order by Pay.tblVam.fldId desc

	if (@fieldname=N'CheckPersonalId')
	SELECT  TOP (@h) Pay.tblVam.fldId, Pay.tblVam.fldPersonalId,  fldTarikhDaryaft, Pay.tblVam.fldTypeVam, CASE WHEN (fldTypeVam = 1) 
               THEN N'کوتاه مدت' WHEN (fldTypeVam = 2) THEN N'بلند مدت' WHEN (fldTypeVam = 3) THEN N'مسکن' END AS fldTypeVamName, Pay.tblVam.fldMablaghVam, 
              Pay.tblVam.fldStartDate, Pay.tblVam.fldCount, Pay.tblVam.fldMablagh, Pay.tblVam.fldMandeVam, Pay.tblVam.fldStatus, Pay.tblVam.fldUserId, 
               Pay.tblVam.fldDate, Pay.tblVam.fldDesc,Com.fn_FamilyEmployee ( Prs.Prs_tblPersonalInfo.fldEmployeeId) as fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
			   ,CASE WHEN(tblVam.fldStatus=0) THEN N'تسویه شده' ELSE N'تسویه نشده' END AS fldStatusName
			   FROM         Pay.tblVam INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
	WHERE  Pay.tblVam.fldPersonalId = @Value

	if (@fieldname=N'')
	SELECT  TOP (@h) Pay.tblVam.fldId, Pay.tblVam.fldPersonalId,  fldTarikhDaryaft, Pay.tblVam.fldTypeVam, CASE WHEN (fldTypeVam = 1) 
               THEN N'کوتاه مدت' WHEN (fldTypeVam = 2) THEN N'بلند مدت' WHEN (fldTypeVam = 3) THEN N'مسکن' END AS fldTypeVamName, Pay.tblVam.fldMablaghVam, 
               Pay.tblVam.fldStartDate, Pay.tblVam.fldCount, Pay.tblVam.fldMablagh, Pay.tblVam.fldMandeVam, Pay.tblVam.fldStatus, Pay.tblVam.fldUserId, 
               Pay.tblVam.fldDate, Pay.tblVam.fldDesc,Com.fn_FamilyEmployee ( Prs.Prs_tblPersonalInfo.fldEmployeeId) as fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
			   ,CASE WHEN(tblVam.fldStatus=0) THEN N'تسویه شده' ELSE N'تسویه نشده' END AS fldStatusName
			   FROM         Pay.tblVam INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                      where  Com.fn_OrganId(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)=@OrganId
                        order by Pay.tblVam.fldId desc
	
		if (@fieldname=N'All')
	SELECT  TOP (@h) Pay.tblVam.fldId, Pay.tblVam.fldPersonalId,  fldTarikhDaryaft, Pay.tblVam.fldTypeVam, CASE WHEN (fldTypeVam = 1) 
               THEN N'کوتاه مدت' WHEN (fldTypeVam = 2) THEN N'بلند مدت' WHEN (fldTypeVam = 3) THEN N'مسکن' END AS fldTypeVamName, Pay.tblVam.fldMablaghVam, 
               Pay.tblVam.fldStartDate, Pay.tblVam.fldCount, Pay.tblVam.fldMablagh, Pay.tblVam.fldMandeVam, Pay.tblVam.fldStatus, Pay.tblVam.fldUserId, 
               Pay.tblVam.fldDate, Pay.tblVam.fldDesc,Com.fn_FamilyEmployee ( Prs.Prs_tblPersonalInfo.fldEmployeeId) as fldName_Father, tblEmployee.fldCodemeli, Prs.Prs_tblPersonalInfo.fldSh_Personali
			   ,CASE WHEN(tblVam.fldStatus=0) THEN N'تسویه شده' ELSE N'تسویه نشده' END AS fldStatusName
			   FROM         Pay.tblVam INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId
                        order by Pay.tblVam.fldId desc
	
	COMMIT
GO
