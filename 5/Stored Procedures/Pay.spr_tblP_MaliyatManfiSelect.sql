SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblP_MaliyatManfiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldMohasebeId], [fldMablagh], [fldSal], [fldMah], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	FROM   [Pay].[tblP_MaliyatManfi] 
	WHERE  fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldMohasebeId], [fldMablagh], [fldSal], [fldMah], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	FROM   [Pay].[tblP_MaliyatManfi] 
	WHERE  fldDesc LIKE @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMohasebeId], [fldMablagh], [fldSal], [fldMah], [fldUserId], [fldDesc], [fldDate], [fldTimeEdit], [fldEdit] 
	FROM   [Pay].[tblP_MaliyatManfi] 

	COMMIT
GO
