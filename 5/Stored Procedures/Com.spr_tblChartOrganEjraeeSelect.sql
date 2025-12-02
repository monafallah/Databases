SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblChartOrganEjraeeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
	WHERE  tblChartOrganEjraee.fldId = @Value 
	--AND 
	--( tblChartOrganEjraee.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrganEjraee.fldUserId=@UserId or  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	
	if (@fieldname=N'fldOrganId')
		SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
	WHERE  tblChartOrganEjraee.fldOrganId = @Value
	--AND 
	--( tblChartOrganEjraee.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrganEjraee.fldUserId=@UserId or  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	if (@fieldname=N'CheckOrganId')
			SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
	WHERE  tblChartOrganEjraee.fldOrganId = @Value

	
		if (@fieldname=N'fldOrganizationName')
		SELECT     TOP (@h)* FROM (SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId)t
	WHERE  fldOrganizationName LIKE @Value 
	--AND 
	--( tblChartOrganEjraee.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrganEjraee.fldUserId=@UserId or  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

		if (@fieldname=N'fldNoeVahedName')
		SELECT     TOP (@h) * from(SELECT    tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId)t
	WHERE  fldNoeVahedName LIKE @Value 
	
	if (@fieldname=N'fldTitle')
		SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
	WHERE  fldTitle LIKE @Value 
	--AND 
	--( tblChartOrganEjraee.fldUserId=@UserId OR (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrganEjraee.fldUserId=@UserId or  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))


	if (@fieldname=N'CheckTitle')
	SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
	WHERE  fldTitle LIKE @Value

		if (@fieldname=N'fldPID')
		begin
			if(@Value=0)
				SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
				WHERE  tblChartOrganEjraee.fldPId is null
			else 
				SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
				WHERE  tblChartOrganEjraee.fldPId=@Value
		end


if (@fieldname=N'fldPID_Auto')/*fargh*/
		begin
			if(@Value=0)
				SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
				WHERE  tblChartOrganEjraee.fldPId is null
				AND 
	(  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0  or  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

			else 
				SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
				WHERE  tblChartOrganEjraee.fldPId=@Value
				AND 
	( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

		end


	if (@fieldname=N'fldDesc')
		SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
	WHERE  tblChartOrganEjraee.fldDesc like @Value

		if (@fieldname=N'ALL')
	SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId

	if (@fieldname=N'')
	SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
					  WHERE tblChartOrganEjraee.fldPId IS NULL
					  --AND (tblChartOrganEjraee.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrganEjraee.fldUserId=@UserId or  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))


	if (@fieldname=N'fldNoeVahed')
		SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
	WHERE  tblChartOrganEjraee.fldNoeVahed =@Value


		if (@fieldname=N'fldNoeVahed_Auto')/*fargh*/
		SELECT     TOP (@h) tblChartOrganEjraee.fldId, tblChartOrganEjraee.fldTitle, tblChartOrganEjraee.fldPId, tblChartOrganEjraee.fldOrganId, tblChartOrganEjraee.fldNoeVahed, tblChartOrganEjraee.fldUserId, 
                      tblChartOrganEjraee.fldDesc, tblChartOrganEjraee.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                     --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrganEjra',tblChartOrganEjraee.fldId) )
					 Com.fn_stringDecode(tblOrganization.fldName) AS fldOrganizationName
FROM         tblChartOrganEjraee INNER JOIN
                  Com.tblOrganization ON Com.tblChartOrganEjraee.fldOrganId = Com.tblOrganization.fldId
	WHERE  tblChartOrganEjraee.fldNoeVahed =@Value
			AND 
	( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0  or  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))


	COMMIT
GO
