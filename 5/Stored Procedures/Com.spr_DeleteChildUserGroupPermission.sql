SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_DeleteChildUserGroupPermission](@UserGroup_ModuleOrganId INT,@AppId NVARCHAR(max))
AS
DECLARE @userId INT

DECLARE @temp TABLE(id int)
;WITH USERs AS (SELECT fldId,fldUserId FROM com.tblUser
WHERE fldId=@userId
UNION ALL
SELECT u.fldId ,u.fldUserId FROM com.tblUser AS u INNER JOIN 
USERs ON  u.fldUserId=USERs.fldId AND u.fldId<>1
)
INSERT INTO @temp
SELECT fldId FROM USERs
ORDER BY USERs.fldId
DECLARE @fldUserGroupId INT,@fldModuleOrganId INT
SELECT @fldUserGroupId=fldUserGroupId,@fldModuleOrganId=fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan WHERE fldId=@UserGroup_ModuleOrganId
SELECT @userId=fldUserID FROM com.tblUserGroup WHERE fldid=@fldUserGroupId
--SELECT * FROM Com.tblUser_Group WHERE fldUserGroupId=@fldUserGroupId
--SELECT * FROM Com.tblUserGroup_ModuleOrgan WHERE fldModuleOrganId=@mudoleorganId and fldUserGroupId IN (SELECT fldid FROM Com.tblUserGroup  WHERE fldUserID IN (SELECT fldUserSelectId FROM Com.tblUser_Group WHERE fldUserGroupId=@fldUserGroupId))
DELETE FROM Com.tblPermission WHERE fldUserGroup_ModuleOrganID IN (SELECT fldId FROM Com.tblUserGroup_ModuleOrgan WHERE fldModuleOrganId=@fldModuleOrganId and fldUserGroupId IN (SELECT tblUserGroup.fldid FROM Com.tblUserGroup  WHERE tblUserGroup.fldUserID IN (SELECT id FROM @temp))
) AND fldApplicationPartID IN (SELECT Item FROM Com.Split(@AppId,';'))
GO
