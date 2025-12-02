SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId],  [fldName], [fldAddress], [fldPhone], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldPhone')
	SELECT top(@h) [fldId],  [fldName], [fldAddress], [fldPhone], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar] 
	WHERE  fldPhone like @Value

	if (@fieldname=N'fldAddress')
	SELECT top(@h) [fldId],  [fldName], [fldAddress], [fldPhone], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar] 
	WHERE  fldAddress like @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId],  [fldName], [fldAddress], [fldPhone], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId],  [fldName], [fldAddress], [fldPhone], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar] 
	
	
	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId],  [fldName], [fldAddress], [fldPhone], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [Str].[tblAnbar] 
	WHERE fldName like  @Value

	COMMIT
GO
