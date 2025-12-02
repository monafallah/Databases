SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMessageAttachmentSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldMessageId], [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	,[tblMessageAttachment].fldTitle,fldSize,fldPasvand
	FROM   [Auto].[tblMessageAttachment] 
	outer apply (select fldPasvand,cast(round((DATALENGTH(fldImage)/1024.0)/1024.0,2) as decimal(8,2)) fldSize from com.tblFile where tblFile.fldid=fldFileId)tblfile
	WHERE  fldId=@Value and fldOrganId=@OrganId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldMessageId], [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	,[tblMessageAttachment].fldTitle,fldSize,fldPasvand
	FROM   [Auto].[tblMessageAttachment] 
	outer apply (select fldPasvand,cast(cast(round((DATALENGTH(fldImage)/1024.0)/1024.0,2) as decimal(8,2))as int) fldSize from com.tblFile where tblFile.fldid=fldFileId)tblfile
	WHERE  fldDesc like @Value and fldOrganId=@OrganId


	if (@FieldName='fldTitle')
	SELECT top(@h) [fldId], [fldMessageId], [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	,[tblMessageAttachment].fldTitle,fldSize,fldPasvand
	FROM   [Auto].[tblMessageAttachment] 
	outer apply (select fldPasvand,cast(round((DATALENGTH(fldImage)/1024.0)/1024.0,2) as decimal(8,2)) fldSize from com.tblFile where tblFile.fldid=fldFileId)tblfile
	WHERE  fldTitle like @Value and fldOrganId=@OrganId

	if (@FieldName='fldMessageId')
	SELECT top(@h) [fldId], [fldMessageId], [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	,[tblMessageAttachment].fldTitle,fldSize,fldPasvand
	FROM   [Auto].[tblMessageAttachment] 
	outer apply (select fldPasvand,cast(round((DATALENGTH(fldImage)/1024.0)/1024.0,2) as decimal(8,2)) fldSize from com.tblFile where tblFile.fldid=fldFileId)tblfile
	WHERE  fldMessageId like @Value and fldOrganId=@OrganId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldMessageId], [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	,[tblMessageAttachment].fldTitle,fldSize,fldPasvand
	FROM   [Auto].[tblMessageAttachment] 
	outer apply (select fldPasvand,cast(round((DATALENGTH(fldImage)/1024.0)/1024.0,2) as decimal(8,2)) fldSize from com.tblFile where tblFile.fldid=fldFileId)tblfile

	where  fldOrganId=@OrganId

		if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldMessageId], [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP] 
	,[tblMessageAttachment].fldTitle,fldSize,fldPasvand
	FROM   [Auto].[tblMessageAttachment] 
	outer apply (select fldPasvand,cast(round((DATALENGTH(fldImage)/1024.0)/1024.0,2) as decimal(8,2)) fldSize from com.tblFile where tblFile.fldid=fldFileId)tblfile
	where  fldOrganId=@OrganId

	
	COMMIT
GO
