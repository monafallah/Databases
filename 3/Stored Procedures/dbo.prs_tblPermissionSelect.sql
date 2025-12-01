SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblPermissionSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value2 INT,
	@h int
AS 
	BEGIN TRAN
	declare @fldUserId INT
	SET @Value= dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldUserGroupID], [fldApplicationPartID], [fldDesc]
	FROM   [dbo].[tblPermission] 
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldUserGroupID')
	SELECT top(@h) [fldID], [fldUserGroupID], [fldApplicationPartID], [fldDesc]
	FROM   [dbo].[tblPermission] 
	WHERE  fldUserGroupID = @Value
	
	if (@fieldname=N'fldApplicationPartID')
	SELECT top(@h) [fldID], [fldUserGroupID], [fldApplicationPartID], [fldDesc]
	FROM   [dbo].[tblPermission] 
	WHERE  fldApplicationPartID = @Value and fldUserGroupID=@value2
	
	if (@fieldname=N'HaveAcces')
	begin
		select @fldUserId=fldUserSecondId from tblInputInfo where fldId=@value2
		SELECT  TOP (@h) tblPermission.fldId, tblPermission.fldUserGroupID, tblPermission.fldApplicationPartID, tblPermission.fldDesc
					
		FROM     tblPermission 
			WHERE tblPermission.fldApplicationPartID=@Value And tblPermission.fldUserGroupID in(SELECT     fldUserGroupId FROM  tblUser_Group WHERE [fldUserSelectId]=@fldUserID)
		ORDER BY tblPermission.fldID DESC
	end
	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldUserGroupID], [fldApplicationPartID], [fldDesc]
	FROM   [dbo].[tblPermission] 

	COMMIT
GO
