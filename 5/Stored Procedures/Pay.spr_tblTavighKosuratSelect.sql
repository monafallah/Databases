SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTavighKosuratSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldKosuratId], [fldYear], [fldMonth], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblTavighKosurat] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldKosuratId], [fldYear], [fldMonth], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblTavighKosurat] 
	WHERE fldDesc like  @Value

	
	if (@fieldname=N'fldKosuratId')
	SELECT top(@h) [fldId], [fldKosuratId], [fldYear], [fldMonth], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblTavighKosurat] 
	WHERE fldKosuratId like  @Value
	ORDER BY fldId DESC

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldKosuratId], [fldYear], [fldMonth], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblTavighKosurat] 

	COMMIT
GO
