SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTimeLimit_UserGroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldAppId], [fldTimeLimit], [fldUserGroupId] 
	FROM   [dbo].[tblTimeLimit_UserGroup] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldAppId')
	SELECT top(@h) [fldId], [fldAppId], [fldTimeLimit], [fldUserGroupId] 
	FROM   [dbo].[tblTimeLimit_UserGroup] 
	WHERE fldAppId like  @Value

	if (@fieldname=N'Check')
	SELECT top(@h) [fldId], [fldAppId], [fldTimeLimit], [fldUserGroupId] 
	FROM   [dbo].[tblTimeLimit_UserGroup] 
	WHERE fldAppId =  @Value and fldUserGroupId=@value2

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldAppId], [fldTimeLimit], [fldUserGroupId] 
	FROM   [dbo].[tblTimeLimit_UserGroup] 

	COMMIT
GO
