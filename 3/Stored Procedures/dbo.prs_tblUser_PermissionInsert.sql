SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[prs_tblUser_PermissionInsert] 

    @fldUserSelectId int,
    @fldAppId NVARCHAR(MAX),
 
	@fldInputID int,
    @fldDesc nvarchar(1000)
	
AS 
	
	BEGIN TRAN
		SET @fldDesc =dbo.fn_TextNormalize(@fldDesc) 

	DECLARE @App TABLE( AppId int)
	DECLARE @flag TINYINT=0
	INSERT INTO @App
	        ( AppId )
	SELECT Item FROM dbo.Split(@fldAppId,';')WHERE Item<>0
	

	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblUser_Permission] 
	INSERT INTO [dbo].[tblUser_Permission] ([fldId], [fldUserSelectId], [fldAppId], [fldIsAccept],  [fldDesc])

	SELECT ROW_NUMBER() OVER (ORDER BY AppId)+@fldID,@fldUserSelectId, AppId, 1,   @fldDesc FROM @App WHERE AppId NOT IN (SELECT        tblPermission.fldApplicationPartID
FROM            tblUser_Group INNER JOIN
                         tblUserGroup ON tblUser_Group.fldUserGroupID = tblUserGroup.fldID INNER JOIN
                         tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID WHERE fldUserSelectID=@fldUserSelectId)
	
	
	IF (@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END 
IF(@flag=0)
BEGIN

SELECT @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblUser_Permission] 
INSERT INTO [dbo].[tblUser_Permission] ([fldId], [fldUserSelectId], [fldAppId], [fldIsAccept], [fldDesc])


	SELECT ROW_NUMBER() OVER (ORDER BY  tblPermission.fldId)+@fldID,@fldUserSelectId, fldApplicationPartID, 0,   @fldDesc
FROM            tblUser_Group INNER JOIN
                         tblUserGroup ON tblUser_Group.fldUserGroupID = tblUserGroup.fldID INNER JOIN
                         tblPermission ON tblUserGroup.fldID = tblPermission.fldUserGroupID WHERE fldUserSelectID=@fldUserSelectId
						 and  tblPermission.fldApplicationPartID NOT in (SELECT AppId FROM @App)
	if (@@ERROR<>0)
			ROLLBACK


end
	COMMIT
GO
