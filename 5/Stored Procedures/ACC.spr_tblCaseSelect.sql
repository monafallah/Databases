SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCaseSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCase] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldCaseTypeId')
	SELECT top(@h) [fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCase] 
	WHERE  fldCaseTypeId like @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCase] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldCaseTypeId], [fldSourceId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCase] 

	COMMIT
GO
