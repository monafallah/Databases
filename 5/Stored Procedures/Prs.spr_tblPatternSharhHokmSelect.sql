SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPatternSharhHokmSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPatternText], [fldHokmType], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblPatternSharhHokm] 
	WHERE  fldId = @Value
	
		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPatternText], [fldHokmType], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblPatternSharhHokm] 
	WHERE  fldDesc = @Value

	if (@fieldname=N'fldPatternText')
	SELECT top(@h) [fldId], [fldPatternText], [fldHokmType], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblPatternSharhHokm] 
	WHERE  fldPatternText LIKE @Value
	
	if (@fieldname=N'fldHokmType')
	SELECT top(@h) [fldId], [fldPatternText], [fldHokmType], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblPatternSharhHokm] 
	WHERE  fldHokmType LIKE @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPatternText], [fldHokmType], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Prs].[tblPatternSharhHokm] 

	COMMIT
GO
