SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCaseTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCaseType] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCaseType] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCaseType] 



if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCaseType] 
	WHERE fldName like  @Value
	COMMIT
GO
