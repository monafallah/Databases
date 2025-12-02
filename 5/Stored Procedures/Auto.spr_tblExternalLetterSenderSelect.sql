SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblExternalLetterSenderSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldLetterId], [fldMessageId], /*[fldAshkhasHoghoghiId],*/fldShakhsHoghoghiTitlesId, [fldDate], [fldOrganId], [fldUserId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblExternalLetterSender] 
	WHERE  fldId=@Value and fldOrganId =@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldLetterId], [fldMessageId],/* [fldAshkhasHoghoghiId],*/fldShakhsHoghoghiTitlesId [fldDate], [fldOrganId], [fldUserId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblExternalLetterSender] 
	WHERE  fldDesc like @Value  and fldOrganId =@organId

	
	if (@FieldName='fldLetterID')
	SELECT top(@h) [fldId], [fldLetterId], [fldMessageId],/* [fldAshkhasHoghoghiId], */fldShakhsHoghoghiTitlesId,[fldDate], [fldOrganId], [fldUserId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblExternalLetterSender] 
	WHERE  fldLetterID like @Value  and fldOrganId =@organId

		if (@FieldName='fldMessageId')
	SELECT top(@h) [fldId], [fldLetterID], [fldMessageId],/* [fldAshkhasHoghoghiId],*/fldShakhsHoghoghiTitlesId, [fldDate], [fldOrganId], [fldUserId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblExternalLetterSender] 
	WHERE  fldMessageId like @Value  and fldOrganId =@organId


	if (@FieldName='')
	SELECT top(@h) [fldId], [fldLetterId], [fldMessageId],/* [fldAshkhasHoghoghiId], */fldShakhsHoghoghiTitlesId [fldDate], [fldOrganId], [fldUserId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblExternalLetterSender] 
	where   fldOrganId =@organId
	
		if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldLetterId], [fldMessageId],/* [fldAshkhasHoghoghiId],*/fldShakhsHoghoghiTitlesId [fldDate], [fldOrganId], [fldUserId], [fldDesc], [fldIP] 
	FROM   [Auto].[tblExternalLetterSender] 
	where   fldOrganId =@organId
	
	COMMIT
GO
