SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterActionTypeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldTitleActionType], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Auto].[tblLetterActionType] 
	WHERE  fldId=@Value and fldOrganId=@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldTitleActionType], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Auto].[tblLetterActionType] 
	WHERE  fldDesc like @Value  and fldOrganId=@organId

	if (@FieldName='fldTitleActionType')
	SELECT top(@h) [fldId], [fldTitleActionType], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Auto].[tblLetterActionType] 
	WHERE  fldTitleActionType like @Value  and fldOrganId=@organId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldTitleActionType], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Auto].[tblLetterActionType] 
	where   fldOrganId=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldTitleActionType], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Auto].[tblLetterActionType]
	 where fldOrganId=@organId

	COMMIT
GO
