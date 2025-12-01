SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_User_PermissionAppIdSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@UserLoginId int,
	@NameTable varchar(100),
	@Id varchar(20)
AS 
BEGIN TRAN
declare @UserType tinyint
SET @value =dbo.fn_TextNormalize(@value)
select @UserType=fldUserType from tblUser where fldId=@UserId
if (@fieldname=N'PermissionUser')
begin
	SELECT * from(SELECT  [fldAppId]  FROM dbo.tblUser_Permission INNER JOIN 
	dbo.tblApplicationPart ON fldAppId=dbo.tblApplicationPart.fldID
	 WHERE fldUserSelectId=@UserId AND fldIsAccept=1 AND (fldUserType=@UserType OR @UserType=3 or fldUserType=3)
	UNION
	SELECT fldApplicationPartID
	FROM            tblUser_Group INNER JOIN
							 tblUserGroup ON tblUser_Group.fldUserGroupID = tblUserGroup.fldID INNER JOIN
							 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID WHERE fldUserSelectID=@UserId AND (fldUserType=@UserType OR @UserType=3 or fldUserType=3)) AS t
	except
	SELECT  [fldAppId] FROM dbo.tblUser_Permission INNER JOIN 
	dbo.tblApplicationPart ON fldAppId=dbo.tblApplicationPart.fldID
	 WHERE fldUserSelectId=@UserId AND fldIsAccept=0 AND (fldUserType=@UserType OR @UserType=3 or fldUserType=3)
	
	end

	
	if (@fieldname=N'HaveAcces')
	begin
		declare @TimeLimit int
			select @TimeLimit=max(fldTimeLimit)  from (
			select fldTimeLimit from tblTimeLimit_UserGroup as t
			inner join tblUser_Group as u on  u.fldUserGroupID=t.fldUserGroupId
			where fldAppId=@Value and fldUserSelectID=@UserLoginId
			union
			select fldTimeLimit from tblTimeLimit_User
			where fldAppId=@Value and fldUserId=@UserLoginId
			)t2
		if exists(select * from tblApplicationPart where fldID=@Value and fldTimeLimit=0) or @TimeLimit is null
		begin
			SELECT * from(SELECT  [fldAppId]  FROM dbo.tblUser_Permission inner join
			tblApplicationPart on fldAppId=tblApplicationPart.fldID
			 WHERE fldAppId=@Value AND  fldUserSelectId=@UserLoginId AND fldIsAccept=1 and (fldUserType=@UserType or @UserType=3 or fldUserType=3)
			UNION
			SELECT fldApplicationPartID
			FROM            tblUser_Group INNER JOIN
									 tblUserGroup ON tblUser_Group.fldUserGroupID = tblUserGroup.fldID INNER JOIN
									 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID 
			WHERE fldApplicationPartID=@Value AND  fldUserSelectID=@UserLoginId and (fldUserType=@UserType or @UserType=3 or fldUserType=3)) AS t
			except
			SELECT  [fldAppId] FROM dbo.tblUser_Permission inner join
			tblApplicationPart on fldAppId=tblApplicationPart.fldID
			WHERE fldAppId=@Value AND  fldUserSelectId=@UserLoginId AND fldIsAccept=0 and (fldUserType=@UserType or @UserType=3 or fldUserType=3)
		end
		else
		begin
			declare @SysStartTime datetime,@DATEDIFF_Time int,@query nvarchar(500)=''
			declare @temp table(SysStartTime datetime)

			set @query='select top(1) 	CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,[StartTime]),DATENAME(TzOffset, SYSDATETIMEOFFSET()))) 
			from [dbo].'+@NameTable+'History where fldID='+@id+ ' order by [StartTime] asc'
			
			insert @temp
			execute(@query)

			if not exists(select * from @temp)
			begin
				set @query='select 	CONVERT(datetime,SWITCHOFFSET(CONVERT(datetimeoffset,[StartTime]),DATENAME(TzOffset, SYSDATETIMEOFFSET()))) 
				from [dbo].'+@NameTable+'  where fldID='+@id
				insert @temp
				execute(@query)
			end

			set @DATEDIFF_Time=DATEDIFF(MINUTE,@SysStartTime,GETDATE())

			SELECT * from(SELECT  [fldAppId]  FROM dbo.tblUser_Permission inner join
			tblApplicationPart on fldAppId=tblApplicationPart.fldID
			 WHERE fldAppId=@Value AND  fldUserSelectId=@UserLoginId AND fldIsAccept=1 and (fldUserType=@UserType or @UserType=3 or fldUserType=3)
			 and @DATEDIFF_Time<=@TimeLimit
			UNION
			SELECT fldApplicationPartID
			FROM            tblUser_Group INNER JOIN
									 tblUserGroup ON tblUser_Group.fldUserGroupID = tblUserGroup.fldID INNER JOIN
									 tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID 
			WHERE fldApplicationPartID=@Value AND  fldUserSelectID=@UserLoginId and (fldUserType=@UserType or @UserType=3 or fldUserType=3)
			and @DATEDIFF_Time<=@TimeLimit) AS t
			
			except
			SELECT  [fldAppId] FROM dbo.tblUser_Permission inner join
			tblApplicationPart on fldAppId=tblApplicationPart.fldID
			WHERE fldAppId=@Value AND  fldUserSelectId=@UserLoginId AND fldIsAccept=0 and (fldUserType=@UserType or @UserType=3 or fldUserType=3)
		end
	end
commit tran
GO
