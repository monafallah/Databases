SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[fn_GetUserGroup](@UserId INT,@UserGroupId INT)
RETURNS INT
AS
BEGIN
	DECLARE @count INT
	DECLARE @UserGroupByUserID TABLE(id INT,title NVARCHAR(max),PermissionId INT,AppId int)
	DECLARE @UserGroup TABLE(id INT,title NVARCHAR(max),PermissionId int,AppId int)

	INSERT INTO @UserGroupByUserID
		 SELECT     Com.tblUserGroup.fldId, Com.tblUserGroup.fldTitle, Com.tblPermission.fldId AS Expr1, Com.tblPermission.fldApplicationPartID
FROM         Com.tblUserGroup INNER JOIN
                      Com.tblUser_Group ON Com.tblUserGroup.fldId = Com.tblUser_Group.fldUserGroupId INNER JOIN
                      Com.tblUserGroup_ModuleOrgan ON Com.tblUserGroup.fldId = Com.tblUserGroup_ModuleOrgan.fldUserGroupId INNER JOIN
                      Com.tblPermission ON Com.tblUserGroup_ModuleOrgan.fldId = Com.tblPermission.fldUserGroup_ModuleOrganID
							 WHERE fldUserSelectID=@UserId


	INSERT INTO @UserGroup
SELECT     Com.tblUserGroup.fldId, Com.tblUserGroup.fldTitle, Com.tblPermission.fldId AS Expr1, Com.tblPermission.fldApplicationPartID
FROM         Com.tblUserGroup INNER JOIN
                      Com.tblUser_Group ON Com.tblUserGroup.fldId = Com.tblUser_Group.fldUserGroupId INNER JOIN
                      Com.tblUserGroup_ModuleOrgan ON Com.tblUserGroup.fldId = Com.tblUserGroup_ModuleOrgan.fldUserGroupId INNER JOIN
                      Com.tblPermission ON Com.tblUserGroup_ModuleOrgan.fldId = Com.tblPermission.fldUserGroup_ModuleOrganID
							 WHERE  tblUserGroup.fldID=@UserGroupId  

	SELECT @count=COUNT(*) FROM @UserGroup
	WHERE AppId NOT IN (SELECT AppId FROM @UserGroupByUserID)
	RETURN @count
END
GO
