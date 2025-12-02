SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 NVARCHAR(50),
	@h int
AS 
	BEGIN TRAN
	--DECLARE @organ TABLE (id int)
	--;WITH organ as	(
	--SELECT    fldId    
	--FROM            Com.tblOrganization
	--WHERE fldId=@organId 
	--UNION ALL
	--SELECT t.fldId FROM Com.tblOrganization AS t
	--INNER JOIN organ ON t.fldPId=organ.fldId
	-- )
	-- INSERT INTO @organ 
	--		 ( id )
	-- SELECT organ.fldId FROM organ

	if (@h=0) set @h=2147483647
	--SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive, --Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  Com.tblUser.fldId = @Value
	
	if (@fieldname=N'fldId_Search')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  Com.tblUser.fldId = @Value --AND Com.tblUser.fldOrganId IN (SELECT Id FROM @organ)
	
	if (@fieldname=N'fldEmployId')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive, --Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  Com.tblUser.fldEmployId = @Value --AND Com.tblUser.fldOrganId IN (SELECT Id FROM @organ)

	if (@fieldname=N'fldUserName')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  fldUserName like @Value --AND Com.tblUser.fldOrganId IN (SELECT Id FROM @organ)

	if (@fieldname=N'CheckEmployId')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  Com.tblUser.fldEmployId = @Value 

	if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  Com.tblUser.fldId IN (SELECT        Com.tblUser_Group.fldUserSelectId
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUserGroup ON Com.tblUser_Group.fldUserGroupId = Com.tblUserGroup.fldId INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblUserGroup.fldId = Com.tblUserGroup_ModuleOrgan.fldUserGroupId INNER JOIN
                         Com.tblModule_Organ ON Com.tblUserGroup_ModuleOrgan.fldModuleOrganId = Com.tblModule_Organ.fldId INNER JOIN
                         Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = Com.tblOrganization.fldId WHERE fldUserSelectId=Com.tblUser.fldId AND fldOrganId=@Value) 

	
	if (@fieldname=N'CheckUserName')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  Com.tblUser.fldUserName = @Value 
	
		if (@fieldname=N'fldCodemeli')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  fldCodemeli like @Value --AND Com.tblUser.fldOrganId IN (SELECT Id FROM @organ)
	
	
	/*	if (@fieldname=N'fldNameOrgan')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive, Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  Com.tblOrganization.fldName like @Value --AND Com.tblUser.fldOrganId IN (SELECT Id FROM @organ)*/
	
	
		if (@fieldname=N'fldNameEmployee')
	SELECT     TOP (@h) * FROM (	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId )te
	WHERE  fldNameEmployee like @Value --AND te.fldOrganId IN (SELECT Id FROM @organ)
	
		
	

		if (@fieldname=N'fldActive_DeactiveName')
	SELECT     TOP (@h)* FROM (	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive, --Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId  )te
	WHERE  fldActive_DeactiveName LIKE @Value --AND te.fldOrganId IN (SELECT Id FROM @organ)
	
	if (@fieldname=N'CheckPass')
		SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  [fldUserName] = @Value AND [fldPassword]=@value2


	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
	WHERE  Com.tblUser.fldDesc like @Value


	if (@fieldname=N'')
		SELECT     TOP (@h) Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive,-- Com.tblUser.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیرفعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                     /*Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan,*/ Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldCodemeli
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId 
                      --WHERE  Com.tblUser.fldOrganId IN (SELECT Id FROM @organ)
	COMMIT
GO
