SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserGroup_ModuleOrganSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT TOP (@h) Com.tblUserGroup_ModuleOrgan.fldId, Com.tblUserGroup_ModuleOrgan.fldUserGroupId, Com.tblUserGroup_ModuleOrgan.fldModuleOrganId, 
                  Com.tblUserGroup_ModuleOrgan.fldUserID, Com.tblUserGroup_ModuleOrgan.fldDesc, Com.tblUserGroup_ModuleOrgan.fldDate, com.fn_stringDecode(Com.tblOrganization.fldName)+'('+Com.tblModule.fldTitle+')' as fldModuleOrganName
FROM     Com.tblUserGroup_ModuleOrgan INNER JOIN
                  Com.tblModule_Organ ON Com.tblUserGroup_ModuleOrgan.fldModuleOrganId = Com.tblModule_Organ.fldId INNER JOIN
                  Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Com.tblModule ON Com.tblModule_Organ.fldModuleId = Com.tblModule.fldId 
	WHERE  Com.tblUserGroup_ModuleOrgan.fldId = @Value

	if (@fieldname=N'fldUserGroupId')
		SELECT TOP (@h) Com.tblUserGroup_ModuleOrgan.fldId, Com.tblUserGroup_ModuleOrgan.fldUserGroupId, Com.tblUserGroup_ModuleOrgan.fldModuleOrganId, 
                  Com.tblUserGroup_ModuleOrgan.fldUserID, Com.tblUserGroup_ModuleOrgan.fldDesc, Com.tblUserGroup_ModuleOrgan.fldDate, com.fn_stringDecode(Com.tblOrganization.fldName)+'('+Com.tblModule.fldTitle+')' as fldModuleOrganName
FROM     Com.tblUserGroup_ModuleOrgan INNER JOIN
                  Com.tblModule_Organ ON Com.tblUserGroup_ModuleOrgan.fldModuleOrganId = Com.tblModule_Organ.fldId INNER JOIN
                  Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Com.tblModule ON Com.tblModule_Organ.fldModuleId = Com.tblModule.fldId  
	WHERE  fldUserGroupId like( @Value)

	if (@fieldname=N'fldModuleOrganId')
		SELECT TOP (@h) Com.tblUserGroup_ModuleOrgan.fldId, Com.tblUserGroup_ModuleOrgan.fldUserGroupId, Com.tblUserGroup_ModuleOrgan.fldModuleOrganId, 
                  Com.tblUserGroup_ModuleOrgan.fldUserID, Com.tblUserGroup_ModuleOrgan.fldDesc, Com.tblUserGroup_ModuleOrgan.fldDate,com.fn_stringDecode(Com.tblOrganization.fldName)+'('+Com.tblModule.fldTitle+')' as fldModuleOrganName
FROM     Com.tblUserGroup_ModuleOrgan INNER JOIN
                  Com.tblModule_Organ ON Com.tblUserGroup_ModuleOrgan.fldModuleOrganId = Com.tblModule_Organ.fldId INNER JOIN
                  Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Com.tblModule ON Com.tblModule_Organ.fldModuleId = Com.tblModule.fldId  
	WHERE  fldModuleOrganId like( @Value)
	
	if (@fieldname=N'fldModuleOrganName')
		select *from( SELECT TOP (@h) Com.tblUserGroup_ModuleOrgan.fldId, Com.tblUserGroup_ModuleOrgan.fldUserGroupId, Com.tblUserGroup_ModuleOrgan.fldModuleOrganId, 
                  Com.tblUserGroup_ModuleOrgan.fldUserID, Com.tblUserGroup_ModuleOrgan.fldDesc, Com.tblUserGroup_ModuleOrgan.fldDate,com.fn_stringDecode(Com.tblOrganization.fldName)+'('+Com.tblModule.fldTitle+')' as fldModuleOrganName
FROM     Com.tblUserGroup_ModuleOrgan INNER JOIN
                  Com.tblModule_Organ ON Com.tblUserGroup_ModuleOrgan.fldModuleOrganId = Com.tblModule_Organ.fldId INNER JOIN
                  Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Com.tblModule ON Com.tblModule_Organ.fldModuleId = Com.tblModule.fldId  )temp
	WHERE  fldModuleOrganName like( @Value)

	if (@fieldname=N'ByUserId')
	SELECT TOP (@h) Com.tblUserGroup_ModuleOrgan.fldId, Com.tblUserGroup_ModuleOrgan.fldUserGroupId, Com.tblUserGroup_ModuleOrgan.fldModuleOrganId, 
                  Com.tblUserGroup_ModuleOrgan.fldUserID, Com.tblUserGroup_ModuleOrgan.fldDesc, Com.tblUserGroup_ModuleOrgan.fldDate, com.fn_stringDecode(Com.tblOrganization.fldName)+'('+Com.tblModule.fldTitle+')' as fldModuleOrganName
FROM     Com.tblUserGroup_ModuleOrgan INNER JOIN
                  Com.tblModule_Organ ON Com.tblUserGroup_ModuleOrgan.fldModuleOrganId = Com.tblModule_Organ.fldId INNER JOIN
                  Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Com.tblModule ON Com.tblModule_Organ.fldModuleId = Com.tblModule.fldId 

	if (@fieldname=N'')
	SELECT TOP (@h) Com.tblUserGroup_ModuleOrgan.fldId, Com.tblUserGroup_ModuleOrgan.fldUserGroupId, Com.tblUserGroup_ModuleOrgan.fldModuleOrganId, 
                  Com.tblUserGroup_ModuleOrgan.fldUserID, Com.tblUserGroup_ModuleOrgan.fldDesc, Com.tblUserGroup_ModuleOrgan.fldDate, com.fn_stringDecode(Com.tblOrganization.fldName)+'('+Com.tblModule.fldTitle+')' as fldModuleOrganName
FROM     Com.tblUserGroup_ModuleOrgan INNER JOIN
                  Com.tblModule_Organ ON Com.tblUserGroup_ModuleOrgan.fldModuleOrganId = Com.tblModule_Organ.fldId INNER JOIN
                  Com.tblOrganization ON Com.tblModule_Organ.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Com.tblModule ON Com.tblModule_Organ.fldModuleId = Com.tblModule.fldId 

	COMMIT
GO
