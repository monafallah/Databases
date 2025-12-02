SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblOrganizationalPostsEjraeeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(300),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
	WHERE  tblOrganizationalPostsEjraee.fldId = @Value 
	--AND 
	--( Com.tblOrganizationalPostsEjraee.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPostsEjraee.fldUserId=@Value or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	
	
	if (@fieldname=N'fldTitle')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
	WHERE  tblOrganizationalPostsEjraee.fldTitle = @Value 
--	AND 	( Com.tblOrganizationalPostsEjraee.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPostsEjraee.fldUserId=@Value or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	
	if (@fieldname=N'fldChartOrganId')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
	WHERE  tblOrganizationalPostsEjraee.fldChartOrganId = @Value-- AND 	(Com.tblOrganizationalPostsEjraee.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPostsEjraee.fldUserId=@Value  or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	
	if (@fieldname=N'fldPID')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
	WHERE  tblOrganizationalPostsEjraee.fldPID = @Value

	if (@fieldname=N'fldDesc')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
	WHERE  tblOrganizationalPostsEjraee.fldDesc like @Value 

		if (@fieldname=N'fldNameChart')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
	WHERE   Com.tblChartOrganEjraee.fldTitle like @Value 

			if (@fieldname=N'fldTitlePID')
SELECT TOP (@h) * FROM (SELECT Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                 Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId)t
	WHERE   fldTitlePID like @Value 



if (@fieldname=N'fldOrganId')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
	WHERE  Com.tblChartOrganEjraee.fldOrganId = @Value -- AND 	( Com.tblOrganizationalPostsEjraee.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPostsEjraee.fldUserId=@Value or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	 	if (@fieldname=N'ALL')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId 

	if (@fieldname=N'')
SELECT TOP (@h) Com.tblOrganizationalPostsEjraee.fldId, Com.tblOrganizationalPostsEjraee.fldTitle, Com.tblOrganizationalPostsEjraee.fldOrgPostCode, Com.tblOrganizationalPostsEjraee.fldChartOrganId, 
                  Com.tblOrganizationalPostsEjraee.fldPID, Com.tblOrganizationalPostsEjraee.fldUserId, Com.tblOrganizationalPostsEjraee.fldDate, Com.tblOrganizationalPostsEjraee.fldDesc, 
                  Com.tblChartOrganEjraee.fldTitle AS fldNameChart, Com.tblChartOrganEjraee.fldOrganId,(SELECT fldTitle FROM Com.tblOrganizationalPostsEjraee AS a WHERE a.fldid=fldPID) AS fldTitlePID
FROM     Com.tblOrganizationalPostsEjraee INNER JOIN
                  Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId
                      			  WHERE tblOrganizationalPostsEjraee.fldPId IS NULL
								   --AND
           --           			  	( Com.tblOrganizationalPostsEjraee.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblOrganizationalPostsEjraee.fldUserId=@Value  or  fldOrganId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))



	COMMIT
GO
