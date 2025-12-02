SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblMahalFotSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldNameMahal], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Dead].[tblMahalFot] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldNameMahal], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Dead].[tblMahalFot] 
	WHERE  fldDesc like @Value

	if (@FieldName='fldNameMahal')
	SELECT top(@h) [fldId], [fldNameMahal], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Dead].[tblMahalFot] 
	WHERE  fldNameMahal like @Value


	if (@FieldName='')
	SELECT top(@h) [fldId], [fldNameMahal], [fldUserId], [fldIP], [fldDesc], [fldDate] 
	FROM   [Dead].[tblMahalFot] 

	
	COMMIT
GO
