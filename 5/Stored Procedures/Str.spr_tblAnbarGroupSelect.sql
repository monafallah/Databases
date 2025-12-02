SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarGroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbarGroup] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbarGroup] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbarGroup] 
	WHERE fldName like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbarGroup] 

	if (@fieldname=N'')
	SELECT top(@h) tblAnbarGroup.[fldId], tblAnbarGroup.[fldName], tblAnbarGroup.[fldDesc], tblAnbarGroup.[fldDate], tblAnbarGroup.[fldIP], tblAnbarGroup.[fldUserId] 
	FROM   [Str].[tblAnbarGroup] 
	inner join tblAnbarTree on tblAnbarTree.fldGroupId=tblAnbarGroup.fldId
	COMMIT
GO
