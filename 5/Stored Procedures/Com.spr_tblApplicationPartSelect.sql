SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblApplicationPartSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate] ,fldModuleId
	FROM   [Com].[tblApplicationPart] 
	WHERE  fldId = @Value
	
	
	IF(@UserId =1)
	BEGIN
	if (@fieldname=N'fldPID' and @Value<>'0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate] ,fldModuleId
		FROM   [Com].[tblApplicationPart] 
		WHERE  fldPID = @Value and fldModuleId  IN (SELECT fldModuleId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldId=@Value1))
	else if (@fieldname=N'fldPID' and @Value='0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate] ,fldModuleId
		FROM   [Com].[tblApplicationPart] 
		WHERE  fldPID is null  and fldModuleId  IN (SELECT fldModuleId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldId=@Value1))
	END
	else
	begin
	if (@fieldname=N'fldPID' and @Value<>'0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate] ,fldModuleId
		FROM   [Com].[tblApplicationPart] 
		WHERE  fldPID = @Value AND fldID IN ( SELECT     Com.tblPermission.fldApplicationPartID
FROM         Com.tblUserGroup INNER JOIN
                      Com.tblUser_Group ON Com.tblUserGroup.fldId = Com.tblUser_Group.fldUserGroupId INNER JOIN
                      Com.tblUserGroup_ModuleOrgan ON Com.tblUserGroup.fldId = Com.tblUserGroup_ModuleOrgan.fldUserGroupId INNER JOIN
                      Com.tblPermission ON Com.tblUserGroup_ModuleOrgan.fldId = Com.tblPermission.fldUserGroup_ModuleOrganID
							 WHERE fldUserSelectID=@UserId)
							  and fldModuleId IN (SELECT fldModuleId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldId=@Value1))
	else if (@fieldname=N'fldPID' and @Value='0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate] ,fldModuleId
		FROM   [Com].[tblApplicationPart] 
		WHERE  fldPID is null AND fldID IN ( SELECT     Com.tblPermission.fldApplicationPartID
FROM         Com.tblUserGroup INNER JOIN
                      Com.tblUser_Group ON Com.tblUserGroup.fldId = Com.tblUser_Group.fldUserGroupId INNER JOIN
                      Com.tblUserGroup_ModuleOrgan ON Com.tblUserGroup.fldId = Com.tblUserGroup_ModuleOrgan.fldUserGroupId INNER JOIN
                      Com.tblPermission ON Com.tblUserGroup_ModuleOrgan.fldId = Com.tblPermission.fldUserGroup_ModuleOrganID
							 WHERE fldUserSelectID=@UserId)
							  and fldModuleId  IN (SELECT fldModuleId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldId=@Value1))
		
	end


	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate] ,fldModuleId
	FROM   [Com].[tblApplicationPart] 
	WHERE  fldDesc like  @Value
	

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate] ,fldModuleId
	FROM   [Com].[tblApplicationPart] 
	WHERE fldpid IS NULL
    
	if (@fieldname=N'Child')
	BEGIN
		;WITH App as	(
		SELECT    [fldId], [fldTitle], [fldPID], [fldUserID], [fldDesc], [fldDate] ,fldModuleId   
		FROM            Com.tblApplicationPart
		WHERE fldId=@Value		UNION ALL
		SELECT t.[fldId], t.[fldTitle], t.[fldPID], t.[fldUserID], t.[fldDesc], t.[fldDate] ,t.fldModuleId FROM Com.tblApplicationPart AS t
		INNER JOIN App ON t.fldPId=App.fldId
			)
			SELECT * FROM App
			ORDER BY App.fldId
	END 
	COMMIT
GO
