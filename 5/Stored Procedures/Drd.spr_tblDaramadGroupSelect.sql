SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldUserId], [fldDesc], [fldDate], [fldTitle] ,fldOrganId
	FROM   [Drd].[tblDaramadGroup] 
	WHERE  [tblDaramadGroup].fldId = @Value
	

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldUserId], [fldDesc], [fldDate], [fldTitle] ,fldOrganId
	FROM   [Drd].[tblDaramadGroup] 
	WHERE fldDesc like  @Value  AND fldorganId=@OrganId

	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldUserId], [fldDesc], [fldDate], [fldTitle] ,fldOrganId
	FROM   [Drd].[tblDaramadGroup] 
	WHERE fldTitle like  @Value  AND fldorganId=@OrganId

		if (@fieldname=N'InElamAvarez')
	SELECT top(@h) [fldId], [fldUserId], [fldDesc], [fldDate], [fldTitle] ,fldOrganId
	FROM   [Drd].[tblDaramadGroup] 
	WHERE fldDesc like  @Value  AND fldorganId=@OrganId

	UNION ALL
	SELECT 0,1,'',GETDATE(),N'هیچکدام',0

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldUserId], [fldDesc], [fldDate], [fldTitle] ,fldOrganId
	FROM   [Drd].[tblDaramadGroup]
	where   fldorganId=@OrganId 

	COMMIT
GO
