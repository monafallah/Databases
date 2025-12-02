SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblMahiyatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldDesc], [fldDate], [fldIp], [fldUserId] 
	FROM   [ACC].[tblMahiyat] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldDesc], [fldDate], [fldIp], [fldUserId] 
	FROM   [ACC].[tblMahiyat] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldDesc], [fldDate], [fldIp], [fldUserId] 
	FROM   [ACC].[tblMahiyat]
	
	
	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldDesc], [fldDate], [fldIp], [fldUserId] 
	FROM   [ACC].[tblMahiyat] 
	WHERE fldTitle like  @Value 

	COMMIT
GO
