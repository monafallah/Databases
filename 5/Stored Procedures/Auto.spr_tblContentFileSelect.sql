SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblContentFileSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldName], [fldLetterText], [fldLetterId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldType] 
	FROM   [Auto].[tblContentFile] 
	WHERE  fldId=@Value and fldOrganId=@OrganId
	
	if (@FieldName='fldLetterId')
	SELECT top(@h) [fldId], [fldName], [fldLetterText], [fldLetterId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldType] 
	FROM   [Auto].[tblContentFile] 
	WHERE  fldLetterId=@Value and fldOrganId=@OrganId

	if (@FieldName='MatnLetterId')
	SELECT top(@h) [fldId], [fldName], [fldLetterText], [fldLetterId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldType] 
	FROM   [Auto].[tblContentFile] 
		WHERE  fldLetterId=@Value and 
	not exists (select * from auto.tblLetterAttachment l where l.fldLetterId=[tblContentFile].fldLetterId) and fldOrganId=@OrganId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldLetterText], [fldLetterId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldType] 
	FROM   [Auto].[tblContentFile] 
	WHERE  fldDesc like @Value and fldOrganId=@OrganId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldName], [fldLetterText], [fldLetterId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldType] 
	FROM   [Auto].[tblContentFile] 
	where  fldOrganId=@OrganId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldName], [fldLetterText], [fldLetterId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP], [fldType] 
	FROM   [Auto].[tblContentFile] 
	where  fldOrganId=@OrganId




	COMMIT
GO
