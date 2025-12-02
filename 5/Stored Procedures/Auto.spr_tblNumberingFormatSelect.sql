SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblNumberingFormatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganID INT ,
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldID], [fldYear], [fldSecretariatID], [fldNumberFormat], [fldStartNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblNumberingFormat] 
	WHERE  fldId = @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldID], [fldYear], [fldSecretariatID], [fldNumberFormat], [fldStartNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblNumberingFormat] 
	WHERE fldDesc like  @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'')
	SELECT top(@h) [fldID], [fldYear], [fldSecretariatID], [fldNumberFormat], [fldStartNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblNumberingFormat]
	
	if (@fieldname=N'fldOrganID')
	SELECT top(@h) [fldID], [fldYear], [fldSecretariatID], [fldNumberFormat], [fldStartNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblNumberingFormat] 
	WHERE fldOrganID=@fldOrganID
	
	if (@fieldname=N'fldSecretariatID')
	SELECT top(@h) [fldID], [fldYear], [fldSecretariatID], [fldNumberFormat], [fldStartNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblNumberingFormat] 
	WHERE fldSecretariatID like  @Value AND fldOrganID=@fldOrganID 

	if (@fieldname=N'check_fldSecretariatID')
	SELECT top(@h) [fldID], [fldYear], [fldSecretariatID], [fldNumberFormat], [fldStartNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblNumberingFormat] 
	WHERE fldSecretariatID like  @Value

    if (@fieldname=N'fldYear_SecretariatID')
	SELECT top(@h) [fldID], [fldYear], [fldSecretariatID], [fldNumberFormat], [fldStartNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP] 
	FROM   [Auto].[tblNumberingFormat] 
	WHERE fldYear like  @Value AND fldSecretariatID=@fldOrganID
	COMMIT
GO
