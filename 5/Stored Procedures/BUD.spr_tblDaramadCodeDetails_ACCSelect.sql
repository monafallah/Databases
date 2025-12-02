SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblDaramadCodeDetails_ACCSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldCodingAcc_DetailsId], [fldType], [fldTypeID], [fldUserId], [fldIp], [fldDate] 
	FROM   [BUD].[tblDaramadCodeDetails_ACC] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldCodingAcc_DetailsId], [fldType], [fldTypeID], [fldUserId], [fldIp], [fldDate] 
	FROM   [BUD].[tblDaramadCodeDetails_ACC] 
	WHERE [fldCodingAcc_DetailsId] like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldCodingAcc_DetailsId], [fldType], [fldTypeID], [fldUserId], [fldIp], [fldDate] 
	FROM   [BUD].[tblDaramadCodeDetails_ACC] 

	COMMIT
GO
