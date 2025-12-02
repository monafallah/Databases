SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblBaskolDocumentSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldTozinId], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] ,
	fldPasvand
	FROM   [Weigh].[tblBaskolDocument] 
	cross apply (select fldPasvand from com.tblFile f where fldid=fldFileId)tblfile
	WHERE  fldId=@Value and fldOrganId=@organId

	if (@FieldName='fldTozinId')
	SELECT top(@h) [fldId], [fldTozinId], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] ,
	fldPasvand
	FROM   [Weigh].[tblBaskolDocument] 
	cross apply (select fldPasvand from com.tblFile f where fldid=fldFileId)tblfile
	WHERE  fldTozinId=@Value and fldOrganId=@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldTozinId], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] ,
	fldPasvand
	FROM   [Weigh].[tblBaskolDocument] 
	cross apply (select fldPasvand from com.tblFile f where fldid=fldFileId)tblfile
	WHERE  fldDesc like @Value and fldOrganId=@organId
		
	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldTozinId], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] ,
	fldPasvand
	FROM   [Weigh].[tblBaskolDocument] 
	cross apply (select fldPasvand from com.tblFile f where fldid=fldFileId)tblfile
	WHERE  fldOrganId=@organId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldTozinId], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] ,
	fldPasvand
	FROM   [Weigh].[tblBaskolDocument] 
	cross apply (select fldPasvand from com.tblFile f where fldid=fldFileId)tblfile
	WHERE  fldOrganId=@organId
	
	COMMIT
GO
