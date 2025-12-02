SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblStatusMahalKhedmatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle] 
	FROM   [Pay].[tblStatusMahalKhedmat] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldTitle')
	SELECT top(@h) [fldId], [fldTitle] 
	FROM   [Pay].[tblStatusMahalKhedmat] 
	WHERE fldTitle like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle] 
	FROM   [Pay].[tblStatusMahalKhedmat] 

	COMMIT
GO
