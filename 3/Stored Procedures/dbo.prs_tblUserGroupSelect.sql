SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUserGroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	declare @UserType tinyint
	SET @Value=dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
DECLARE @temp TABLE(id int)
;WITH USERs AS (SELECT fldId,fldUserId FROM dbo.tblUser
WHERE fldId=@UserId
UNION ALL
SELECT u.fldId ,u.fldUserId FROM dbo.tblUser AS u INNER JOIN 
USERs ON  u.fldUserId=USERs.fldId AND u.fldId<>1
)
INSERT INTO @temp
SELECT fldId FROM USERs
ORDER BY USERs.fldId

	if (@fieldname=N'fldId')
	SELECT top(@h)  tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldUserId,
		tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp
		
	FROM   [dbo].[tblUserGroup] 
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId

	WHERE  tblUserGroup.fldId = @Value
	ORDER BY tblUserGroup.fldorder desc
		
	if (@fieldname=N'fldUserId')
	SELECT top(@h)  tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldUserId,
		tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp
		
	FROM   [dbo].[tblUserGroup] 
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId
	WHERE  tblUserGroup.fldInputID = @Value 
	ORDER BY tblUserGroup.fldorder desc
	
	if (@fieldname=N'fldTitle')
	SELECT top(@h)  tblUserGroup.fldID, tblUserGroup.fldTitle ,tblUserGroup.fldInputID,tblUserGroup.fldUserId,
		tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
	(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp
		
	FROM   [dbo].[tblUserGroup] 
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId
	WHERE  tblUserGroup.fldTitle LIKE @Value 
	ORDER BY tblUserGroup.fldorder desc

	if (@fieldname=N'fldId_ByUserId')
	SELECT [fldID], [fldTitle],[fldInputID], [fldDesc], [fldDate],[fldUserType],[t].[fldUserType_Name],Name_Family,fldTimeStamp,fldUserId
FROM ( 
		SELECT    tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp,tblUserGroup.fldUserId,
		CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
		,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
	,tblUserGroup.fldorder 
	FROM       tblUserGroup
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId 
	WHERE tblUserGroup.[fldID] LIKE @Value )t
	WHERE (fldUserId IN (  SELECT id FROM @temp) /*OR t.fldWithGrant=1*/)OR @userId=1
	order by fldorder

	
	if (@fieldname=N'fldTitle_ByUserId')
	SELECT  [fldID], [fldTitle],[fldInputID], [fldDesc], [fldDate],[fldUserType],[t].[fldUserType_Name],Name_Family,fldTimeStamp,fldUserId
FROM ( 
		SELECT    tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp,tblUserGroup.fldUserId,
		CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
		,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
	,tblUserGroup.fldorder
	FROM       tblUserGroup
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId 
	WHERE tblUserGroup.[fldTitle] LIKE @Value )t
	WHERE (fldUserId IN (  SELECT id FROM @temp) /*OR t.fldWithGrant=1*/)OR @userId=1
	order by fldorder


	if (@fieldname=N'fldDesc_ByUserId')
	SELECT [fldID], [fldTitle],[fldInputID], [fldDesc], [fldDate],[fldUserType],[t].[fldUserType_Name],Name_Family,fldTimeStamp,fldUserId
FROM ( 
		SELECT    tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp,tblUserGroup.fldUserId,
		CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
		,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
	,tblUserGroup.fldorder
	FROM       tblUserGroup
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId 
	WHERE tblUserGroup.fldDesc LIKE @Value )t
	WHERE (fldUserId IN (  SELECT id FROM @temp) /*OR t.fldWithGrant=1*/)OR @userId=1
	order by fldorder

	if (@fieldname=N'ByUserId')
	SELECT[fldID], [fldTitle],[fldInputID], [fldDesc], [fldDate],[fldUserType],[t].[fldUserType_Name],Name_Family,fldTimeStamp,fldUserId
FROM ( 
		SELECT    tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp,tblUserGroup.fldUserId,
		CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
		,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
	,tblUserGroup.fldorder
	FROM       tblUserGroup
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId
	)t
	WHERE (fldUserId IN (  SELECT id FROM @temp) /*OR t.fldWithGrant=1*/)OR @userId=1
	order by fldorder
	
 
	if (@fieldname=N'Rpt_ByUserId')
	SELECT [fldID], [fldTitle],[fldInputID], [fldDesc], [fldDate],[fldUserType],[t].[fldUserType_Name],Name_Family,fldTimeStamp,fldUserId
FROM ( 
		SELECT    tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp,tblUserGroup.fldUserId,
		CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
		,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
	,tblUserGroup.fldorder
	FROM       tblUserGroup
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId 
	)t
	WHERE (fldUserId IN (  SELECT id FROM @temp) /*OR t.fldGrant=1*/)OR @userId=1 
	order by fldorder
	
	if (@fieldname=N'fldNameFamily_ByUserId')
	SELECT  [fldID], [fldTitle],[fldInputID], [fldDesc], [fldDate],[fldUserType],[t].[fldUserType_Name],Name_Family,fldTimeStamp,fldUserId
FROM ( 
		SELECT    tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp,tblUserGroup.fldUserId,
		CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
		,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
		THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
	,tblUserGroup.fldorder
	FROM       tblUserGroup
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId 
	)t
	WHERE t.Name_Family like @value and( (fldUserId IN (  SELECT id FROM @temp) /*OR t.fldWithGrant=1*/)OR @userId=1)
	order by fldorder
	
	if (@fieldname=N'')
	SELECT top(@h)  tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldUserId,
		tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
	(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp
		,tblUserGroup.fldorder
	FROM   [dbo].[tblUserGroup] 
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId
	
	ORDER BY tblUserGroup.fldorder desc

	if (@fieldname=N'Copy_Pr')
	begin
		select @UserType=fldUserType from tblUserGroup where fldID=@Value
		SELECT top(@h)  tblUserGroup.fldID, tblUserGroup.fldTitle,tblUserGroup.fldInputID,tblUserGroup.fldUserId,
			tblUserGroup.fldDesc, tblUserGroup.fldDate,dbo.tblUserGroup.fldUserType,CASE WHEN dbo.tblUserGroup.fldUserType=1 THEN N'کاربر سامانه ' WHEN dbo.tblUserGroup.fldUserType=2 THEN N'کاربر وب سرویس' WHEN dbo.tblUserGroup.fldUserType=3 THEN N' کاربر سامانه و وب سرویس ' END AS fldUserType_Name,
		(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,cast(tblUserGroup.fldTimeStamp as int)as fldTimeStamp
		,tblUserGroup.fldorder
		FROM   [dbo].[tblUserGroup] 
		inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
		inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
		left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId
		and tblUserGroup.fldID<>@Value and (tblUserGroup.fldUserId IN (  SELECT id FROM @temp) OR @userId=1 ) and (tblUserGroup.fldUserType=@UserType or @UserType=3)
		ORDER BY tblUserGroup.fldorder desc
	end
	COMMIT

GO
