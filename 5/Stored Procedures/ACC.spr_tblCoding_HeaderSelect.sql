SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_HeaderSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId INT ,
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldYear], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCoding_Header] 
	WHERE  fldId = @Value AND fldOrganId=@fldOrganId
	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldYear], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCoding_Header] 
	WHERE fldDesc like  @Value AND fldOrganId=@fldOrganId

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldYear], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCoding_Header]
	where  fldOrganId=@fldOrganId
	
	if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldYear], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCoding_Header] 
	WHERE fldYear like  @Value AND fldOrganId=@fldOrganId 

	COMMIT
GO
