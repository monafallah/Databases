SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbar_TreeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldAnbarId], [fldAnbarTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar_Tree] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldAnbarId], [fldAnbarTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar_Tree] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldAnbarId], [fldAnbarTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar_Tree] 

	COMMIT
GO
