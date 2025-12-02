SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblFiscalYearSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId INT,
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldOrganId], [fldYear], [fldDesc], [fldDate], [fldIP], [fldUserId] ,cast( 1 as bit) test
	FROM   [ACC].[tblFiscalYear] 
	WHERE  fldId = @Value AND fldOrganId=@fldOrganId

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldOrganId], [fldYear], [fldDesc], [fldDate], [fldIP], [fldUserId] ,cast( 1 as bit) test
	FROM   [ACC].[tblFiscalYear] 
	WHERE fldDesc like  @Value AND fldOrganId=@fldOrganId

	if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldOrganId], [fldYear], [fldDesc], [fldDate], [fldIP], [fldUserId],cast( 1 as bit) test
	FROM   [ACC].[tblFiscalYear] 
	WHERE fldYear like  @Value AND fldOrganId=@fldOrganId

	if (@fieldname=N'fldOrganId')
	SELECT top(@h) [fldId], [fldOrganId], [fldYear], [fldDesc], [fldDate], [fldIP], [fldUserId] ,cast( 1 as bit) test
	FROM   [ACC].[tblFiscalYear] 
	WHERE fldOrganId=@fldOrganId

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldOrganId], [fldYear], [fldDesc], [fldDate], [fldIP], [fldUserId] ,cast( 1 as bit) test
	FROM   [ACC].[tblFiscalYear]
		WHERE  fldOrganId=@fldOrganId

	COMMIT
GO
