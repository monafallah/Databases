SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMaliyatManfiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldMablagh], [fldMohasebeId], [fldSal], [fldMah], [fldUserId], [fldDesc], [fldDate]
	FROM   [Pay].[tblMaliyatManfi] 
	WHERE  fldId = @Value


		if (@fieldname=N'fldDate')
	SELECT top(@h) [fldId], [fldMablagh], [fldMohasebeId], [fldSal], [fldMah], [fldUserId], [fldDesc], [fldDate]
	FROM   [Pay].[tblMaliyatManfi] 
	WHERE  fldDate LIKE @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMablagh], [fldMohasebeId], [fldSal], [fldMah], [fldUserId], [fldDesc], [fldDate]
	FROM   [Pay].[tblMaliyatManfi] 

	COMMIT
GO
