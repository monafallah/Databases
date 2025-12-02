SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingLevelSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=Com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldName], [fldFiscalBudjeId], [fldArghamNum], [fldOrganId], [fldDesc], [fldUserId], [fldDate], [fldIP] 
	FROM   [BUD].[tblCodingLevel] 
	WHERE  fldId=@Value and fldOrganId=@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldFiscalBudjeId], [fldArghamNum], [fldOrganId], [fldDesc], [fldUserId], [fldDate], [fldIP] 
	FROM   [BUD].[tblCodingLevel] 
	WHERE  fldDesc like @Value  and fldOrganId=@organId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldName], [fldFiscalBudjeId], [fldArghamNum], [fldOrganId], [fldDesc], [fldUserId], [fldDate], [fldIP] 
	FROM   [BUD].[tblCodingLevel] 
	where   fldOrganId=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldName], [fldFiscalBudjeId], [fldArghamNum], [fldOrganId], [fldDesc], [fldUserId], [fldDate], [fldIP] 
	FROM   [BUD].[tblCodingLevel] 
	where   fldOrganId=@organId

	
	COMMIT
GO
