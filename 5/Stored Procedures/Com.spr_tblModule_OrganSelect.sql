SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblModule_OrganSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
	WHERE  (Com.tblModule_Organ.fldId = @Value)  --AND fldModuleId IN (SELECT fldModuleId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldId FROM Com.tblUserGroup WHERE fldId IN(SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ))
	
	if (@fieldname=N'fldModuleId')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
	WHERE  fldModuleId = @Value AND ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblModule_Organ.fldUserId=@UserId or tblModule_Organ.fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldId FROM Com.tblUserGroup WHERE fldId IN(SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) )))                   
	
	
	if (@fieldname=N'CheckModuleId')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
	WHERE  fldModuleId = @Value
	
		if (@fieldname=N'CheckOrganId')
SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate,Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId

FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
	WHERE  fldOrganId = @Value
	
	if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate,Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId

FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
	WHERE  fldOrganId = @Value AND ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblModule_Organ.fldUserId=@UserId or  tblModule_Organ.fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldId FROM Com.tblUserGroup WHERE fldId IN(SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) )))
	
		if (@fieldname=N'fldNameOrgan')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
	WHERE tblOrganization.fldName LIKE @Value AND ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblModule_Organ.fldUserId=@UserId or  tblModule_Organ.fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldId FROM Com.tblUserGroup WHERE fldId IN(SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) )))
	
	
		if (@fieldname=N'Formul')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
             WHERE fldModuleId IN (1,2) AND (@UserId=1 or tblModule_Organ.fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldId FROM Com.tblUserGroup WHERE fldId IN(SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) )))
	
		if (@fieldname=N'fldNameModule')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate,Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
	WHERE  tblModule.fldTitle  LIKE @Value AND  ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblModule_Organ.fldUserId=@UserId or  tblModule_Organ.fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldId FROM Com.tblUserGroup WHERE fldId IN(SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) )))
	
		if (@fieldname=N'fldUserId')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate,Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
                      WHERE  ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblModule_Organ.fldUserId=@UserId or  tblModule_Organ.fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldId FROM Com.tblUserGroup WHERE fldId IN(SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) )))

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
	WHERE  Com.tblModule_Organ.fldDesc like @Value 
	
	if (@fieldname=N'ByUserId')/*این select متفاوت است*/
  SELECT         Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblUserGroup_ModuleOrgan ON Com.tblModule_Organ.fldId = Com.tblUserGroup_ModuleOrgan.fldModuleOrganId INNER JOIN
                      Com.tblUserGroup ON Com.tblUserGroup_ModuleOrgan.fldUserGroupId = Com.tblUserGroup.fldId INNER JOIN
                      Com.tblUser_Group ON Com.tblUserGroup.fldId = Com.tblUser_Group.fldUserGroupId INNER JOIN Com.tblOrganization
                      ON tblOrganization.fldId = tblModule_Organ.fldOrganId INNER JOIN Com.tblModule
                      ON tblModule.fldId = tblModule_Organ.fldModuleId
                      WHERE fldUserSelectId=@value
                      GROUP BY  Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate,(tblOrganization.fldName), tblModule.fldTitle 
	

	if (@fieldname=N'')
	SELECT     TOP (@h) Com.tblModule_Organ.fldId, Com.tblModule_Organ.fldOrganId, Com.tblModule_Organ.fldModuleId, Com.tblModule_Organ.fldUserId, Com.tblModule_Organ.fldDesc, 
                      Com.tblModule_Organ.fldDate, Com.fn_stringDecode(tblOrganization.fldName)AS fldNameOrgan, tblModule.fldTitle AS fldNameModule, tblModule.fldTitle+'('+[Com].[fn_stringDecode](tblOrganization.fldName)+')' AS fldNameModule_Organ
,ISNULL((SELECT    TOP(1)    Com.tblPermission.fldId
FROM            Com.tblPermission INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId WHERE fldModuleOrganId=Com.tblModule_Organ.fldId),0) AS fldPermissionId
FROM         Com.tblModule_Organ INNER JOIN
                      Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                     Com.tblModule ON Com.tblModule_Organ.fldModuleId = tblModule.fldId
                     WHERE   ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblModule_Organ.fldUserId=@UserId or  tblModule_Organ.fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId IN (SELECT fldId FROM Com.tblUserGroup WHERE fldId IN(SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) )))

	COMMIT
GO
