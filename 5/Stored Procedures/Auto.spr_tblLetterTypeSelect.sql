SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganID INT ,
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldLetterType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblLetterType] 
	WHERE  fldId = @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldID], [fldLetterType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblLetterType] 
	WHERE fldDesc like  @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldLetterType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblLetterType]
	
	
	if (@fieldname=N'fldOrganID')
	SELECT top(@h) [fldID], [fldLetterType], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblLetterType] 
	WHERE  fldOrganID=@fldOrganID 

	COMMIT
GO
