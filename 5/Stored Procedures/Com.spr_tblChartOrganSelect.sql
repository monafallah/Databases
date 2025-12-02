SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblChartOrganSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
	WHERE  tblChartOrgan.fldId = @Value AND 
	( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	
	if (@fieldname=N'fldOrganId')
	SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
	WHERE  tblChartOrgan.fldOrganId = @Value AND 
	( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	if (@fieldname=N'CheckOrganId')
	SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
	WHERE  tblChartOrgan.fldOrganId = @Value

	
		if (@fieldname=N'fldOrganizationName')
	SELECT     TOP (@h)* FROM (SELECT      tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
WHERE 	( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))
)t
	WHERE  fldOrganizationName LIKE @Value  
			
			IF (@fieldname=N'fldNoeVahedName')
	SELECT     TOP (@h)* FROM (SELECT    tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
WHERE 	( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))
)t
	WHERE  fldNoeVahedName LIKE @Value  

	
	if (@fieldname=N'fldTitle')
SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
	WHERE  fldTitle LIKE @Value AND 
	( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))


	if (@fieldname=N'CheckTitle')
SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
	WHERE  fldTitle LIKE @Value

		if (@fieldname=N'fldPID')
SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
	WHERE  tblChartOrgan.fldPId = @Value


		if (@fieldname=N'fldPID_Organ')
SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
	WHERE  tblChartOrgan.fldPId = @Value and fldOrganId is not null

	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
	WHERE  tblChartOrgan.fldDesc like @Value

	if (@fieldname=N'ALL')
SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
					  WHERE 
	 ( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))


	if (@fieldname=N'')
SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
					  WHERE tblChartOrgan.fldPId IS NULL AND 
	( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	if (@fieldname=N'Chart_Organ')
SELECT     TOP (@h) tblChartOrgan.fldId, tblChartOrgan.fldTitle, tblChartOrgan.fldPId, tblChartOrgan.fldOrganId, tblChartOrgan.fldNoeVahed, tblChartOrgan.fldUserId, 
                      tblChartOrgan.fldDesc, tblChartOrgan.fldDate, CASE WHEN fldNoeVahed = 1 THEN N'عادی ' WHEN fldNoeVahed = 2 THEN N'دبیر خانه' END AS fldNoeVahedName, 
                   --(select Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId= [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) )
				   Com.fn_stringDecode(o.fldName) AS fldOrganizationName
	FROM         tblChartOrgan
	left join tblOrganization as o on o.fldId=tblChartOrgan.fldOrganId
					  WHERE tblChartOrgan.fldPId IS NULL AND 
	( tblChartOrgan.fldUserId=@UserId OR  (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR Com.tblChartOrgan.fldUserId=@UserId or  [Com].[fn_OrganWithChartId]('ChartOrgan',tblChartOrgan.fldId) IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))
	and fldOrganId is not null
	COMMIT
GO
