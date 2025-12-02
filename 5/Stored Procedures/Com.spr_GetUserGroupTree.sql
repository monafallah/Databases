SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_GetUserGroupTree](@userId INT,@UserLoginId INT)
AS
DECLARE @temp TABLE(id int)
;WITH USERs AS (SELECT fldId,fldUserId FROM com.tblUser
WHERE fldId=@UserLoginId
UNION ALL
SELECT u.fldId ,u.fldUserId FROM com.tblUser AS u INNER JOIN 
USERs ON  u.fldUserId=USERs.fldId AND u.fldId<>1
)
INSERT INTO @temp
SELECT fldId FROM USERs
ORDER BY USERs.fldId

select * from ( SELECT    tblUserGroup.fldId ,tblUserGroup.fldTitle,fldUserID
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=com.tblUserGroup.fldid AND fldUserSelectId=@UserLoginId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@UserLoginId) ELSE CAST(0 AS BIT) END AS fldWithGrantLogin
FROM       tblUserGroup )t
 WHERE (fldUserID IN (  SELECT ID FROM @temp) OR t.fldWithGrantLogin=1)OR @UserLoginId=1
                      
GO
