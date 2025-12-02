SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblAssignmentTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganID INT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblAssignmentType] 
	WHERE  fldId = @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'fldType')
	SELECT top(@h) [fldID], [fldType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblAssignmentType] 
	WHERE  fldType like @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldID], [fldType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblAssignmentType] 
	WHERE fldDesc like  @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblAssignmentType] 

	COMMIT
GO
