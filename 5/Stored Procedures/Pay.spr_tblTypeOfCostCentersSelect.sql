SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTypeOfCostCentersSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].[tblTypeOfCostCenters] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].[tblTypeOfCostCenters] 
	WHERE  fldTitle like @Value
	
	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].[tblTypeOfCostCenters] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDate], [fldDesc] 
	FROM   [Pay].[tblTypeOfCostCenters] 

	COMMIT
GO
