SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_RptDastresiKarbaran](@AppId INT,@UserGroup_ModuleOrganID int)
as
SELECT  Com.tblUser.fldId,  Com.tblEmployee.fldName, 
                      Com.tblEmployee.fldFamily,com.Fn_AppId_Name_Dastresi(tblApplicationPart.fldId,Com.tblUser.fldId,@UserGroup_ModuleOrganID) AS NameGroupUser
FROM         Com.tblApplicationPart INNER JOIN
                      Com.tblPermission ON Com.tblApplicationPart.fldId = Com.tblPermission.fldApplicationPartID INNER JOIN
                      Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId INNER JOIN
                      Com.tblUserGroup ON Com.tblUserGroup_ModuleOrgan.fldUserGroupId = Com.tblUserGroup.fldId INNER JOIN
                      Com.tblUser_Group ON Com.tblUserGroup.fldId = Com.tblUser_Group.fldUserGroupId INNER JOIN
                      Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE fldApplicationPartID=@AppId AND fldModuleOrganId=@UserGroup_ModuleOrganID
                      GROUP BY fldName,fldFamily,Com.tblUser.fldId,tblApplicationPart.fldId
                      

                
GO
