SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[prs_TreeUserGroupWithGrantSelect] 
	@UserInfoId INT
AS 
	BEGIN TRAN
	--declare @UserId INT=1
	declare @UserId INT
	select @UserId=fldUserSecondId from tblInputInfo where fldId=@UserInfoId

		select  *  from ( SELECT    [fldID], [fldTitle],[fldUserID], [fldDesc], [fldDate],[fldInputID] 
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END  AS fldGrant
,CASE WHEN EXISTS (SELECT * FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId)
THEN (SELECT fldWithGrant FROM tblUser_Group WHERE fldUserGroupId=tblUserGroup.fldid AND fldUserSelectId=@userId) ELSE CAST(0 AS BIT) END AS fldWithGrant
FROM       tblUserGroup )t
 WHERE ( t.fldGrant=1)

 commit tran
GO
