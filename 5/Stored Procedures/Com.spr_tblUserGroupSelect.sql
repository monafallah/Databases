SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserGroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
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

	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate] 
	FROM   [com].[tblUserGroup] 
	WHERE  fldId = @Value
		ORDER BY fldId desc
	
	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate] 
	FROM   [com].[tblUserGroup] 
	WHERE  fldTitle LIKE @Value
		ORDER BY fldId desc

	if (@fieldname=N'fldId_ByUserId')
	select  [fldID], [fldTitle],[fldUserID], [fldDesc], [fldDate]  from ( SELECT    [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate] 
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
FROM       tblUserGroup
WHERE [fldID] LIKE @Value )t
 WHERE (fldUserID IN (  SELECT ID FROM @temp) OR t.fldWithGrant=1)OR @userId=1

	
	if (@fieldname=N'fldTitle_ByUserId')
	select  [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate]  from ( SELECT    [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate] 
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
FROM       tblUserGroup
WHERE [fldTitle] LIKE @Value )t
 WHERE (fldUserID IN (  SELECT ID FROM @temp) OR t.fldWithGrant=1)OR @userId=1


	if (@fieldname=N'fldDesc_ByUserId')
	select  [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate]  from ( SELECT    [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate] 
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
FROM       tblUserGroup
WHERE fldDesc LIKE @Value )t
 WHERE (fldUserID IN (  SELECT ID FROM @temp) OR t.fldWithGrant=1)OR @userId=1

	if (@fieldname=N'ByUserId')
		select  [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate]  from ( SELECT    [fldID], [fldTitle],[fldUserID], [fldDesc], [fldDate] 
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
FROM       tblUserGroup )t
 WHERE (fldUserID IN (  SELECT ID FROM @temp) OR t.fldWithGrant=1)OR @userId=1
 
	

	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldTitle] ,[fldUserID], [fldDesc], [fldDate] 
	FROM   [com].[tblUserGroup] 

	COMMIT
GO
