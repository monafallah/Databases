SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblParameteriItemsFormulSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldParametrId], [fldFormul], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblParameteriItemsFormul] 
	WHERE  fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldParametrId], [fldFormul], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblParameteriItemsFormul] 
	WHERE  fldDesc LIKE @Value


if (@fieldname=N'fldParametrId')
	SELECT top(@h) [fldId], [fldParametrId], [fldFormul], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblParameteriItemsFormul] 
	WHERE  fldParametrId = @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldParametrId], [fldFormul], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblParameteriItemsFormul] 

	COMMIT
GO
