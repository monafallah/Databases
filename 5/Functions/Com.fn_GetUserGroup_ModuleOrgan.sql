SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [Com].[fn_GetUserGroup_ModuleOrgan](@UserId INT,@UserGroupId INT)
RETURNS INT
AS
BEGIN
DECLARE @count INT=0
DECLARE @UserGroupByUserID TABLE(ModuleOrganId int)
DECLARE @UserGroup TABLE(ModuleOrganId int)
INSERT @UserGroupByUserID
SELECT        Com.tblUserGroup_ModuleOrgan.fldModuleOrganId

FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUserGroup ON Com.tblUser_Group.fldUserGroupId = Com.tblUserGroup.fldId INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblUserGroup.fldId = Com.tblUserGroup_ModuleOrgan.fldUserGroupId
						 WHERE fldUserSelectId=@UserId
INSERT @UserGroup
SELECT        Com.tblUserGroup_ModuleOrgan.fldModuleOrganId
FROM            Com.tblUserGroup INNER JOIN
                         Com.tblUserGroup_ModuleOrgan ON Com.tblUserGroup.fldId = Com.tblUserGroup_ModuleOrgan.fldUserGroupId
WHERE        (Com.tblUserGroup_ModuleOrgan.fldUserGroupId = @UserGroupId)


   SELECT @count=COUNT(*) FROM @UserGroup
	WHERE ModuleOrganId NOT IN (SELECT ModuleOrganId FROM @UserGroupByUserID)    
	
RETURN @count
END                  
GO
