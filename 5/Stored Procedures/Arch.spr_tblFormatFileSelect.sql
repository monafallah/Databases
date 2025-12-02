SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblFormatFileSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldFormatName], [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Arch].[tblFormatFile] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldFormatName')
	SELECT top(@h) [fldId], [fldFormatName], [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Arch].[tblFormatFile] 
	WHERE fldFormatName like  @Value

	if (@fieldname=N'fldPassvand')
	SELECT top(@h) [fldId], [fldFormatName], [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Arch].[tblFormatFile] 
	WHERE fldPassvand like  @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldFormatName], [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Arch].[tblFormatFile] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldFormatName], [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Arch].[tblFormatFile] 

	COMMIT
GO
