SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblBoxTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblBoxType] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldID], [fldType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblBoxType] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblBoxType] 

	COMMIT
GO
