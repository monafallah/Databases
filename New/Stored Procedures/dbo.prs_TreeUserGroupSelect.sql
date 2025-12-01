SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[prs_TreeUserGroupSelect] 
	@UserId INT
AS 
	BEGIN TRAN
	--declare @UserId INT=2
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

		 SELECT    [fldID], [fldTitle],[fldInputID], [fldDesc], [fldDate],fldUserId 

FROM       tblUserGroup 
 WHERE fldUserId  IN (  SELECT id FROM @temp)

 commit tran
GO
