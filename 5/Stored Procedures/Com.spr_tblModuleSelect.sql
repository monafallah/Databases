SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblModuleSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblModule] 
	WHERE  fldId = @Value
	and ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR fldUserId=@UserId or Com.tblModule.fldId IN (SELECT fldModuleId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblModule] 
	WHERE ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR fldUserId=@UserId  or Com.tblModule.fldId IN (SELECT fldModuleId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))
	AND fldTitle LIKE @Value
	
	if (@fieldname=N'CheckTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblModule] 
	WHERE fldTitle LIKE @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblModule] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblModule] 
	WHERE ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR fldUserId=@UserId  or Com.tblModule.fldId IN (SELECT fldModuleId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	COMMIT
GO
