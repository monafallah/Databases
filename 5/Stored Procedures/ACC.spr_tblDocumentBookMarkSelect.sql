SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentBookMarkSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldDocumentRecordeId], [fldArchiveTreeId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [ACC].[tblDocumentBookMark] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldDocumentRecordeId], [fldArchiveTreeId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [ACC].[tblDocumentBookMark] 
	WHERE  fldDesc like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldDocumentRecordeId], [fldArchiveTreeId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [ACC].[tblDocumentBookMark] 
	where fldorganId=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldDocumentRecordeId], [fldArchiveTreeId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [ACC].[tblDocumentBookMark] 
	where fldorganId=@organId
	COMMIT
GO
