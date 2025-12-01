SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUser_GroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldUserGroupID], [fldUserSelectID],fldGrant,fldWithGrant, [fldDesc]
	FROM   [dbo].[tblUser_Group] 
	WHERE  fldId = @Value
		ORDER BY fldId desc
	
	if (@fieldname=N'fldUserSelectId')
	SELECT top(@h) [fldID], [fldUserGroupID], [fldUserSelectID],fldGrant,fldWithGrant, [fldDesc] 
	FROM   [dbo].[tblUser_Group] 
	WHERE  fldUserSelectId = @Value
		ORDER BY fldId desc
	
	if (@fieldname=N'fldUserGroupID')
	SELECT top(@h) [fldID], [fldUserGroupID], [fldUserSelectID],fldGrant,fldWithGrant,flddesc
	FROM   [dbo].[tblUser_Group] 
	WHERE  fldUserGroupID = @Value
		ORDER BY fldId desc

	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldUserGroupID], [fldUserSelectID],fldGrant,fldWithGrant,flddesc
	FROM   [dbo].[tblUser_Group]
		ORDER BY fldId desc 

	COMMIT
GO
