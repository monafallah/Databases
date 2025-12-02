SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentTypeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	FROM   [ACC].[tblDocumentType] 
	WHERE  fldId=@Value 

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	FROM   [ACC].[tblDocumentType] 
	WHERE  fldDesc like @Value 

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	FROM   [ACC].[tblDocumentType] 
	
	
	COMMIT
GO
