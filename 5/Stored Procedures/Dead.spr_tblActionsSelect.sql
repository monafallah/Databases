SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblActionsSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldTitleAction], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [Dead].[tblActions] 
	WHERE  fldId=@Value and fldOrganId=@OrganId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldTitleAction], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [Dead].[tblActions] 
	WHERE  fldDesc like @Value and fldOrganId=@OrganId

	if (@FieldName='fldTitleAction')
	SELECT top(@h) [fldId], [fldTitleAction], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [Dead].[tblActions] 
	WHERE  fldTitleAction like @Value and fldOrganId=@OrganId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldTitleAction], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [Dead].[tblActions] 
	where  fldOrganId=@OrganId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldTitleAction], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	FROM   [Dead].[tblActions] 
	where  fldOrganId=@OrganId

	
	COMMIT
GO
