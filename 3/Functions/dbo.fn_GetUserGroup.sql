SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create FUNCTION [dbo].[fn_GetUserGroup](@UserId INT,@UserGroupId INT)
RETURNS INT
AS
BEGIN
	DECLARE @count INT
	DECLARE @UserGroupByUserID TABLE(id INT,title NVARCHAR(max),PermissionId INT,AppId int)
	DECLARE @UserGroup TABLE(id INT,title NVARCHAR(max),PermissionId int,AppId int)

	INSERT INTO @UserGroupByUserID
		 SELECT        tblUserGroup.fldID, tblUserGroup.fldTitle,tblPermission.fldID,fldApplicationPartID
	FROM            tblUserGroup INNER JOIN
							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
							 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID
							 WHERE fldUserSelectID=@UserId


	INSERT INTO @UserGroup
	SELECT        tblUserGroup.fldID, tblUserGroup.fldTitle,tblPermission.fldID,fldApplicationPartID
	FROM            tblUserGroup INNER JOIN
							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
							 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID
							 WHERE  tblUserGroup.fldID=@UserGroupId  

	SELECT @count=COUNT(*) FROM @UserGroup
	WHERE AppId NOT IN (SELECT AppId FROM @UserGroupByUserID)
	RETURN @count
END
GO
