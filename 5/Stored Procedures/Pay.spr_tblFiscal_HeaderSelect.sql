SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_HeaderSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	WHERE  fldId = @Value
	ORDER BY fldid DESC


	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	WHERE  fldDesc LIKE @Value
	ORDER BY fldid DESC
	
	
	if (@fieldname=N'fldEffectiveDate')
	SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	WHERE  fldEffectiveDate like @Value
	ORDER BY fldid DESC
	
	if (@fieldname=N'fldDateOfIssue')
	SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	WHERE  fldDateOfIssue like @Value
	ORDER BY fldid DESC
	
	IF (@fieldname=N'ExeptHeaderId')
	SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	WHERE  fldId <> @Value2 
	ORDER BY fldid DESC
	
	IF (@fieldname=N'ExeptEffectiveDate')
	SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	WHERE  fldId <> @Value2 AND  fldEffectiveDate like @Value
	ORDER BY fldid DESC
	
	IF (@fieldname=N'ExeptDateOfIssue')
	SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	WHERE  fldId <> @Value2  AND fldDateOfIssue like @Value
	ORDER BY fldid DESC
	
	if (@fieldname=N'EffectiveDate_DateOfIssue')
		SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	WHERE (fldEffectiveDate BETWEEN @value AND @Value2) OR (fldDateOfIssue BETWEEN @value AND @Value2)
	ORDER BY fldid DESC

	
	
	
	if (@fieldname=N'')
		SELECT top(@h) [fldId], [fldEffectiveDate], [fldDateOfIssue], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].tblFiscal_Header 
	ORDER BY fldid DESC
	COMMIT
GO
