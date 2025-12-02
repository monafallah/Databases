SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblGozareshatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTitle] 
	FROM   [Drd].[tblGozareshat] 
	WHERE  fldId = @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTitle] 
	FROM   [Drd].[tblGozareshat] 

	COMMIT
GO
