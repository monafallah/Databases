SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_GetUserGroupTree](@userId INT,@LoginInputId INT,@UserType tinyint)
AS

declare @UserLoginId INT
SELECT @UserLoginId=fldUserSecondId FROM dbo.tblInputInfo WHERE fldid=@LoginInputId
DECLARE @temp TABLE(id int)
;WITH USERs AS (SELECT fldId,fldUserId FROM dbo.tblUser
WHERE fldId=@userId
UNION ALL
SELECT u.fldId ,u.fldUserId FROM dbo.tblUser AS u INNER JOIN 
USERs ON  u.fldUserId=USERs.fldId AND u.fldId<>1
)
INSERT INTO @temp
SELECT fldId FROM USERs
ORDER BY USERs.fldId

select * from ( SELECT    tblUserGroup.fldId ,tblUserGroup.fldTitle,tblUserGroup.fldUserId,tblUserGroup.fldUserType,
(tblAshkhas.fldName+' '+tblAshkhas.fldFamily) as Name_Family,
ISNULL(tblMahalSazmani.fldTitle,'') as NameEdarekol
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@UserLoginId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@UserLoginId) ELSE CAST(0 AS BIT) END AS fldWithGrantLogin
FROM       tblUserGroup
	inner join tbluser on tbluser.fldid=tblUserGroup.fldUserId
	inner join tblAshkhas on tbluser.fldshakhsid=tblAshkhas.fldid
	left outer join tblpersonalinfo on tblAshkhas.fldId=tblpersonalinfo.fldShakhsId
	left outer join tblMahalSazmani on tblpersonalinfo.fldMahalSazmaniId=tblMahalSazmani.fldId 
	)t
 WHERE ((flduserid IN (  SELECT id  FROM @temp) OR t.fldWithGrantLogin=1)OR @UserLoginId=1) and (fldUserType=@UserType /*or @UserType=3 or fldUserType=3*/)
 
                      
GO
