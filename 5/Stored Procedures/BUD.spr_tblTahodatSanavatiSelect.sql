SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblTahodatSanavatiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldD1], [fldD2], [fldD3], [fldH1], [fldH2], [fldH3], [fldH4], [fldFiscalYearId], [fldUserId], [fldIp], [fldDate] 
	FROM   [BUD].[tblTahodatSanavati] 
	WHERE  fldId = @Value


	if (@fieldname=N'fldFiscalYearId')
	SELECT top(@h) [fldId], [fldD1], [fldD2], [fldD3], [fldH1], [fldH2], [fldH3], [fldH4], [fldFiscalYearId], [fldUserId], [fldIp], [fldDate] 
	FROM   [BUD].[tblTahodatSanavati] 
	WHERE fldFiscalYearId =  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldD1], [fldD2], [fldD3], [fldH1], [fldH2], [fldH3], [fldH4], [fldFiscalYearId], [fldUserId], [fldIp], [fldDate] 
	FROM   [BUD].[tblTahodatSanavati] 

	COMMIT
GO
