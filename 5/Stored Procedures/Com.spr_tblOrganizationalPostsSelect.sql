SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblOrganizationalPostsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(300),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
	WHERE  tblOrganizationalPosts.fldId = @Value 
	AND 
	( Com.tblOrganizationalPosts.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPosts.fldUserId=@UserId or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	
	
	if (@fieldname=N'fldTitle')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
	WHERE  com.tblOrganizationalPosts.fldTitle like @Value  
	 AND ( Com.tblOrganizationalPosts.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPosts.fldUserId=@UserId or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	
	if (@fieldname=N'fldChartOrganId')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
	WHERE  tblOrganizationalPosts.fldChartOrganId = @Value AND 	(Com.tblOrganizationalPosts.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPosts.fldUserId=@UserId  or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	
	if (@fieldname=N'fldPID')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId 
	WHERE  tblOrganizationalPosts.fldPID = @Value

	if (@fieldname=N'fldDesc')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
	WHERE  tblOrganizationalPosts.fldDesc like @Value 

		if (@fieldname=N'fldNameChart')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
	WHERE   Com.tblChartOrgan.fldTitle like @Value 

			if (@fieldname=N'fldTitlePID')
SELECT TOP (@h)* FROM (SELECT Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId)t
	WHERE   fldTitlePID like @Value 


if (@fieldname=N'fldOrganId')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
	WHERE  Com.tblChartOrgan.fldOrganId = @Value  AND 	( Com.tblOrganizationalPosts.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPosts.fldUserId=@UserId or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

		if (@fieldname=N'ALL')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
	  
	if (@fieldname=N'')
SELECT TOP (@h) Com.tblOrganizationalPosts.fldId, Com.tblOrganizationalPosts.fldTitle, Com.tblOrganizationalPosts.fldOrgPostCode, Com.tblOrganizationalPosts.fldChartOrganId, 
                  Com.tblOrganizationalPosts.fldPID, Com.tblOrganizationalPosts.fldUserId, Com.tblOrganizationalPosts.fldDate, Com.tblOrganizationalPosts.fldDesc, 
                  Com.tblChartOrgan.fldTitle AS fldNameChart, Com.tblChartOrgan.fldOrganId,(SELECT fldTitle FROM tblOrganizationalPosts AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPosts INNER JOIN
                  Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId
                      			  WHERE tblOrganizationalPosts.fldPId IS NULL AND
                      			  	( Com.tblOrganizationalPosts.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPosts.fldUserId=@UserId  or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))



	COMMIT
GO
