SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUser_PermissionSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldUserSelectId], [fldAppId], [fldIsAccept], [fldDesc]
	FROM   [dbo].[tblUser_Permission] 
	WHERE  fldId = @Value
		ORDER BY fldId desc

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldUserSelectId], [fldAppId], [fldIsAccept], [fldDesc]
	FROM   [dbo].[tblUser_Permission] 
	WHERE fldDesc like  @Value
		ORDER BY fldId desc

	if (@fieldname=N'fldUserSelectId')
	SELECT top(@h) [fldId], [fldUserSelectId], [fldAppId], [fldIsAccept], [fldDesc]
	FROM   [dbo].[tblUser_Permission] 
	WHERE fldUserSelectId like  @Value
	
		ORDER BY fldId desc

	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldUserSelectId], [fldAppId], [fldIsAccept], [fldDesc]
	FROM   [dbo].[tblUser_Permission] 
		ORDER BY fldId desc

	COMMIT
GO
