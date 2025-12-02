SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPermissionSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldUserId INT,
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldUserGroup_ModuleOrganID], [fldApplicationPartID], [fldUserID], [fldDesc], [fldDate] 
	FROM   [Com].[tblPermission] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldApplicationPartID')
	SELECT top(@h) [fldId], [fldUserGroup_ModuleOrganID], [fldApplicationPartID], [fldUserID], [fldDesc], [fldDate] 
	FROM   [Com].[tblPermission] 
	WHERE  fldApplicationPartID = @Value


	
	if (@fieldname=N'HaveAcces')
SELECT  TOP (@h) tblPermission.fldId, tblPermission.fldUserGroup_ModuleOrganID, tblPermission.fldApplicationPartID, tblPermission.fldUserID, tblPermission.fldDesc, 
               tblPermission.fldDate
FROM            Com.tblUserGroup_ModuleOrgan INNER JOIN
                         Com.tblModule_Organ ON Com.tblUserGroup_ModuleOrgan.fldModuleOrganId = Com.tblModule_Organ.fldId INNER JOIN
                         Com.tblUserGroup ON Com.tblUserGroup_ModuleOrgan.fldUserGroupId = Com.tblUserGroup.fldId INNER JOIN
                         Com.tblUser_Group ON Com.tblUserGroup.fldId = Com.tblUser_Group.fldUserGroupId INNER JOIN
                         Com.tblPermission ON Com.tblUserGroup_ModuleOrgan.fldId = Com.tblPermission.fldUserGroup_ModuleOrganID
WHERE    fldApplicationPartID=@Value and    (Com.tblModule_Organ.fldOrganId = @OrganId) AND (Com.tblUser_Group.fldUserSelectId = @fldUserId)
	ORDER BY tblPermission.fldID DESC

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldUserGroup_ModuleOrganID], [fldApplicationPartID], [fldUserID], [fldDesc], [fldDate] 
	FROM   [Com].[tblPermission] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'fldUserGroup_ModuleOrganID')
	SELECT top(@h) [fldId], [fldUserGroup_ModuleOrganID], [fldApplicationPartID], [fldUserID], [fldDesc], [fldDate] 
	FROM   [Com].[tblPermission] 
	WHERE  fldUserGroup_ModuleOrganID like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldUserGroup_ModuleOrganID], [fldApplicationPartID], [fldUserID], [fldDesc], [fldDate] 
	FROM   [Com].[tblPermission] 




		if (@fieldname=N'UserGroupId')
	SELECT TOP(@h)  Com.tblPermission.fldId, Com.tblPermission.fldUserGroup_ModuleOrganID, Com.tblPermission.fldApplicationPartID, Com.tblPermission.fldUserID, Com.tblPermission.fldDesc, Com.tblPermission.fldDate
FROM     Com.tblPermission INNER JOIN
                  Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId INNER JOIN
                  Com.tblUserGroup ON Com.tblUserGroup_ModuleOrgan.fldUserGroupId = Com.tblUserGroup.fldId
	WHERE com.tblUserGroup.fldId = @Value



	COMMIT

GO
