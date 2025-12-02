SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Com].[spr_tblFormatFileSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@organId int,
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldFormatName],fldSize, [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [com].[tblFormatFile] 
	WHERE  fldId = @Value and fldOrganId=@organId

	if (@fieldname=N'fldFormatName')
	SELECT top(@h) [fldId], [fldFormatName],fldSize, [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [com].[tblFormatFile]
	WHERE fldFormatName like  @Value and fldOrganId=@organId

	if (@fieldname=N'fldPassvand')
	SELECT top(@h) [fldId], [fldFormatName],fldSize, [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [com].[tblFormatFile]
	WHERE fldPassvand like  @Value and fldOrganId=@organId

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldFormatName],fldSize, [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [com].[tblFormatFile]
	WHERE fldDesc like  @Value and fldOrganId=@organId

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldFormatName],fldSize, [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [com].[tblFormatFile]
	 where  fldOrganId=@organId

	 if (@fieldname=N'fldOrganId')
	SELECT top(@h) [fldId], [fldFormatName],fldSize, [fldPassvand], [fldIcon], [fldUserId], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [com].[tblFormatFile]
	 where  fldOrganId=@organId
	COMMIT
GO
