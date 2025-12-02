SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareNameHaSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldMokatebatId], [fldReplyTaghsitId], [fldYear], [fldShomare], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblShomareNameHa] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldMokatebatId')
	SELECT top(@h) [fldId], [fldMokatebatId], [fldReplyTaghsitId], [fldYear], [fldShomare], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblShomareNameHa] 
	WHERE  fldMokatebatId = @Value

	if (@fieldname=N'fldReplyTaghsitId')
	SELECT top(@h) [fldId], [fldMokatebatId], [fldReplyTaghsitId], [fldYear], [fldShomare], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblShomareNameHa] 
	WHERE  fldReplyTaghsitId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldMokatebatId], [fldReplyTaghsitId], [fldYear], [fldShomare], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblShomareNameHa] 
	WHERE  fldDesc like @Value
	 
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMokatebatId], [fldReplyTaghsitId], [fldYear], [fldShomare], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblShomareNameHa] 

	COMMIT
GO
