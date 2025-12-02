SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [ACC].[spr_tblTypeHesabSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName], [fldUserId] 
	FROM   [ACC].tbltypehesab 
	WHERE  fldId = @Value

	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName], [fldUserId] 
	FROM   [ACC].tbltypehesab 
	WHERE fldName like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldName], [fldUserId] 
	FROM   [ACC].tbltypehesab

	COMMIT
GO
