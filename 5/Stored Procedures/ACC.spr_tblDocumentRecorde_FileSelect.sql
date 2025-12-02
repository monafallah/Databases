SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecorde_FileSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldDocumentHeaderId], [fldFileId], [fldUserId], [fldDesc], [fldDate] ,fldIP
	FROM   [ACC].[tblDocumentRecorde_File] 
	WHERE  fldId=@Value

	if (@FieldName='fldDocumentHeaderId')
	SELECT top(@h) [fldId], [fldDocumentHeaderId], [fldFileId], [fldUserId], [fldDesc], [fldDate] ,fldIP
	FROM   [ACC].[tblDocumentRecorde_File] 
	WHERE  fldDocumentHeaderId=@Value

	if (@FieldName='fldFileId')
	SELECT top(@h) [fldId], [fldDocumentHeaderId], [fldFileId], [fldUserId], [fldDesc], [fldDate] ,fldIP
	FROM   [ACC].[tblDocumentRecorde_File] 
	WHERE  fldFileId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldDocumentHeaderId], [fldFileId], [fldUserId], [fldDesc], [fldDate] ,fldIP
	FROM   [ACC].[tblDocumentRecorde_File] 
	WHERE  fldDesc like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldDocumentHeaderId], [fldFileId], [fldUserId], [fldDesc], [fldDate] ,fldIP
	FROM   [ACC].[tblDocumentRecorde_File] 

	
	COMMIT
GO
