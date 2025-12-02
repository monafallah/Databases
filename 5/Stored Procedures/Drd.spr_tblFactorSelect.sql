SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblFactorSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldFishId], [fldUserId], [fldDesc], [fldDate] ,fldTarikh
	FROM   [Drd].[tblFactor] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldFishId')
	SELECT top(@h) [fldId], [fldFishId], [fldUserId], [fldDesc], [fldDate] ,fldTarikh
	FROM   [Drd].[tblFactor] 
	WHERE  fldFishId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldFishId], [fldUserId], [fldDesc], [fldDate] ,fldTarikh
	FROM   [Drd].[tblFactor] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldFishId], [fldUserId], [fldDesc], [fldDate] ,fldTarikh
	FROM   [Drd].[tblFactor] 

	COMMIT
GO
