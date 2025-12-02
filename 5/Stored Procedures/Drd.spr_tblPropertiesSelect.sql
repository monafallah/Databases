SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPropertiesSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldEnName], [fldFaName], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblProperties] 
	WHERE  fldId = @Value


	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldEnName], [fldFaName], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblProperties] 

	COMMIT
GO
