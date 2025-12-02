SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_CheckUserGroupForPermission](@UserGroupId INT)
AS

IF EXISTS (SELECT * FROM Com.tblPermission WHERE fldUserGroup_ModuleOrganID IN (SELECT fldId FROM Com.tblUserGroup_ModuleOrgan WHERE fldUserGroupId=@UserGroupId))
SELECT '1' AS fldType
ELSE
SELECT '0' AS fldType
GO
