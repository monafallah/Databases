SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Com].[Fn_AppId_Name_Dastresi](@fldappId int,@userId INT,@UserGroup_Module INT)
returns nvarchar(50)
as 
BEGIN 
declare @title nvarchar(50)='',@a INT
SELECT     @title=@title+tblUserGroup.fldTitle+N'، ' 
FROM             Com.tblPermission INNER JOIN
                      Com.tblUserGroup_ModuleOrgan ON Com.tblPermission.fldUserGroup_ModuleOrganID = Com.tblUserGroup_ModuleOrgan.fldId INNER JOIN
                      Com.tblUserGroup ON Com.tblUserGroup_ModuleOrgan.fldUserGroupId = Com.tblUserGroup.fldId INNER JOIN
                      Com.tblUser_Group ON Com.tblUserGroup.fldId = Com.tblUser_Group.fldUserGroupId
						 where fldUserSelectID=@userId and fldApplicationPartID=@fldappId AND fldModuleOrganId=@UserGroup_Module
						 
IF(@title<>'')
BEGIN
SET @title =SUBSTRING(@title,1,LEN(@title)-1)

END						 
		
	 return @title 
END
GO
