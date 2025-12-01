SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblApplicationPartSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@UserGroupId int,
	@h int
AS 
	BEGIN TRAN
	declare @UserType tinyint
	-- @UserType=1 کاربر سامانه
	-- @UserType=2 کاربر وب سرویس
	-- @UserType=3 هر دو مورد
	SET @Value=dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldTitle], [fldPID],[fldUserType] ,fldTimeLimit
	FROM   [dbo].[tblApplicationPart] 
	WHERE  fldId = @Value 
	if(@UserId=1 and @fieldname=N'fldPID')
	begin
		select @UserType=fldUserType from tblUserGroup where fldID=@UserGroupId
	if (@fieldname=N'fldPID' and @Value<>'0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
		FROM   [dbo].[tblApplicationPart] 
		WHERE  fldPID = @Value  and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
	else if (@fieldname=N'fldPID' and @Value='0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
		FROM   [dbo].[tblApplicationPart] 
		WHERE  fldPID is NULL  and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
		
	end
	else if(@UserId<>1 and @fieldname=N'fldPID')
	begin
		select @UserType=fldUserType from tblUserGroup where fldID=@UserGroupId
	if (@fieldname=N'fldPID' and @Value<>'0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
		FROM   [dbo].[tblApplicationPart] 
		WHERE  fldPID = @Value  AND fldID IN ( SELECT   fldApplicationPartID
	FROM            tblUserGroup INNER JOIN
							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
							 tblPermission ON 
							 tblUserGroup.fldID = tblPermission.fldUserGroupID
							 WHERE fldUserSelectID=@UserId )  AND 
							 fldID NOT IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=0)
							 and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)					 
	UNION 
	SELECT [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
	FROM   [dbo].[tblApplicationPart] 
	WHERE   fldPID = @Value  AND fldID IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=1)						 
			and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)				 
							 
	else 
	
	if (@fieldname=N'fldPID' and @Value='0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
		FROM   [dbo].[tblApplicationPart] 
		WHERE  fldPID is NULL AND fldID IN ( SELECT   fldApplicationPartID
	FROM            tblUserGroup INNER JOIN
							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
							 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID
							 WHERE fldUserSelectID=@UserId  )  AND fldID NOT IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=0)						 
	and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
	UNION 
	SELECT [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
	FROM   [dbo].[tblApplicationPart] 
	WHERE   fldPID  is NULL  AND fldID IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=1)						 
		and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
	end

	-----------------------------------------
	if(@fieldname=N'fldPID_User' and @UserId=1)
	begin
		/*@UserGroupId=آیدی کاربری دسترسی خاص*/
		select @UserType=fldUserType from tblUser where fldID=@UserGroupId
	if (@fieldname=N'fldPID_User' and @Value<>'0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID],[fldUserType] ,fldTimeLimit
		FROM   [dbo].[tblApplicationPart] 
		WHERE  fldPID = @Value and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
	else if (@fieldname=N'fldPID_User' and @Value='0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
		FROM   [dbo].[tblApplicationPart] 
		WHERE  fldPID is NULL and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
		
	end
	else if(@fieldname=N'fldPID_User' and @UserId<>1)
	begin
		select @UserType=fldUserType from tblUser where fldID=@UserId
	if (@fieldname=N'fldPID_User' and @Value<>'0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID],[fldUserType] ,fldTimeLimit
		FROM   [dbo].[tblApplicationPart] 
		WHERE  fldPID = @Value  AND fldID IN ( SELECT   fldApplicationPartID
	FROM            tblUserGroup INNER JOIN
							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
							 tblPermission ON 
							 tblUserGroup.fldID = tblPermission.fldUserGroupID
							 WHERE fldUserSelectID=@UserId )  AND 
							 fldID NOT IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=0)
							 and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)					 
	UNION 
	SELECT [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
	FROM   [dbo].[tblApplicationPart] 
	WHERE   fldPID = @Value AND fldID IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=1)						 
			and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)				 
							 
	else 
	
	if (@fieldname=N'fldPID_User' and @Value='0')
		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
		FROM   [dbo].[tblApplicationPart] 
		WHERE  fldPID is NULL  AND fldID IN ( SELECT   fldApplicationPartID
	FROM            tblUserGroup INNER JOIN
							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
							 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID
							 WHERE fldUserSelectID=@UserId  )  AND fldID NOT IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=0)						 
	and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
	UNION 
	SELECT [fldId], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
	FROM   [dbo].[tblApplicationPart] 
	WHERE   fldPID  is null  AND fldID IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=1)						 
		and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
	end
	-----------------------------------------
	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldTitle], [fldPID], [fldUserType] ,fldTimeLimit
	FROM   [dbo].[tblApplicationPart] 
	WHERE fldPId IS NULL
------------------------------------------------------------------------------------------------------------------------DigitalArchive
	
	
--if (@fieldname=N'fldId_Digital')
--	SELECT top(@h) [fldID], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--	FROM   [dbo].[tblApplicationPart] 
--	WHERE  fldId = @Value AND (fldid>=44 and fldid<=69)
--	if(@UserId=1 and @fieldname=N'fldPID_Digital')
--	begin
--		select @UserType=fldUserType from tblUserGroup where fldID=@UserGroupId
--	if (@fieldname=N'fldPID_Digital' and @Value<>'0')
--		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--		FROM   [dbo].[tblApplicationPart] 
--		WHERE  fldPID = @Value AND (fldid>=44 and fldid<=69)  AND (fldid<44 or fldid>69) and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
--	else if (@fieldname=N'fldPID_Digital' and @Value='0')
--		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--		FROM   [dbo].[tblApplicationPart] 
--		WHERE  fldPID is NULL AND (fldid>=44 and fldid<=69)  AND (fldid<44 or fldid>69) and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
		
--	end
--	else if(@UserId<>1 and @fieldname=N'fldPID_Digital')
--	begin
--		select @UserType=fldUserType from tblUserGroup where fldID=@UserGroupId
--	if (@fieldname=N'fldPID_Digital' and @Value<>'0')
--		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--		FROM   [dbo].[tblApplicationPart] 
--		WHERE  fldPID = @Value AND (fldid>=44 and fldid<=69)  AND fldID IN ( SELECT   fldApplicationPartID
--	FROM            tblUserGroup INNER JOIN
--							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
--							 tblPermission ON 
--							 tblUserGroup.fldID = tblPermission.fldUserGroupID
--							 WHERE fldUserSelectID=@UserId )  AND 
--							 fldID NOT IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=0)
--							 and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)					 
--	UNION 
--	SELECT [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType],[fldUserType] ,fldTimeLimit
--	FROM   [dbo].[tblApplicationPart] 
--	WHERE   fldPID = @Value AND (fldid>=44 and fldid<=69) AND fldID IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=1)						 
--			and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)				 
							 
--	else 
	
--	if (@fieldname=N'fldPID_Digital' and @Value='0')
--		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldDate] ,[fldUserType] ,fldTimeLimit,[fldUserId]
--		FROM   [dbo].[tblApplicationPart] 
--		WHERE  fldPID is NULL AND (fldid>=44 and fldid<=69)  AND fldID IN ( SELECT   fldApplicationPartID
--	FROM            tblUserGroup INNER JOIN
--							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
--							 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID
--							 WHERE fldUserSelectID=@UserId  )  AND fldID NOT IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=0)						 
--	and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
--	UNION 
--	SELECT [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--	FROM   [dbo].[tblApplicationPart] 
--	WHERE   fldPID  is NULL AND (fldid>=44 and fldid<=69)  AND fldID IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=1)						 
--		and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
--	end

--	-----------------------------------------
--	if(@fieldname=N'fldPID_User_Digital' and @UserId=1)
--	begin
--		/*@UserGroupId=آیدی کاربری دسترسی خاص*/
--		select @UserType=fldUserType from tblUser where fldID=@UserGroupId
--	if (@fieldname=N'fldPID_User_Digital' and @Value<>'0')
--		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--		FROM   [dbo].[tblApplicationPart] 
--		WHERE  fldPID = @Value AND (fldid>=44 and fldid<=69)  and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
--	else if (@fieldname=N'fldPID_User_Digital' and @Value='0')
--		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--		FROM   [dbo].[tblApplicationPart] 
--		WHERE  fldPID is NULL AND (fldid>=44 AND fldid<=69)  and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
		
--	end
--	else if(@fieldname=N'fldPID_User_Digital' and @UserId<>1)
--	begin
--		select @UserType=fldUserType from tblUser where fldID=@UserId
--	if (@fieldname=N'fldPID_User_Digital' and @Value<>'0')
--		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--		FROM   [dbo].[tblApplicationPart] 
--		WHERE  fldPID = @Value AND (fldid>=44 and fldid<=69)  AND fldID IN ( SELECT   fldApplicationPartID
--	FROM            tblUserGroup INNER JOIN
--							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
--							 tblPermission ON 
--							 tblUserGroup.fldID = tblPermission.fldUserGroupID
--							 WHERE fldUserSelectID=@UserId )  AND 
--							 fldID NOT IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=0)
--							 and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)					 
--	UNION 
--	SELECT [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType],[fldUserType] ,fldTimeLimit
--	FROM   [dbo].[tblApplicationPart] 
--	WHERE   fldPID = @Value AND (fldid>=44 and fldid<=69)  AND fldID IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=1)						 
--			and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)				 
							 
--	else 
	
--	if (@fieldname=N'fldPID_User_Digital' and @Value='0')
--		SELECT top(@h) [fldId], [fldTitle], [fldPID], [fldDate] ,[fldUserType],[fldUserId]
--		FROM   [dbo].[tblApplicationPart] 
--		WHERE  fldPID is NULL AND (fldid>=44 and fldid<=69)  AND fldID IN ( SELECT   fldApplicationPartID
--	FROM            tblUserGroup INNER JOIN
--							 tblUser_Group ON tblUserGroup.fldID = tblUser_Group.fldUserGroupID INNER JOIN
--							 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID
--							 WHERE fldUserSelectID=@UserId  )  AND fldID NOT IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=0)						 
--	and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
--	UNION 
--	SELECT [fldId], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--	FROM   [dbo].[tblApplicationPart] 
--	WHERE   fldPID  is null  AND (fldid<44 and fldid>69) AND fldID IN (SELECT  [fldAppId]  FROM dbo.tblUser_Permission WHERE  fldUserSelectId=@UserId AND fldIsAccept=1)						 
--		and (tblApplicationPart.fldUserType=@UserType or @UserType=3 or tblApplicationPart.fldUserType=3)
--	end
--	-----------------------------------------
--	if (@fieldname=N'Digital')
--	SELECT top(@h) [fldID], [fldTitle], [fldPID], [fldDate],[fldUserType] ,fldTimeLimit
--	FROM   [dbo].[tblApplicationPart] 
--	WHERE fldPId IS NULL  AND (fldid<44 and fldid>69) 	
	
	
	COMMIT
GO
