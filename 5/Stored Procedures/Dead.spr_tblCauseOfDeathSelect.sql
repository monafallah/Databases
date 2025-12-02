SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblCauseOfDeathSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=Com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldReason], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Dead].[tblCauseOfDeath] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldReason], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Dead].[tblCauseOfDeath] 
	WHERE  fldDesc like @Value

	if (@FieldName='fldReason')
	SELECT top(@h) [fldId], [fldReason], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Dead].[tblCauseOfDeath] 
	WHERE  fldReason like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldReason], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Dead].[tblCauseOfDeath] 

	
	COMMIT
GO
