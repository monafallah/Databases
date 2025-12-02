SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblExternalFishSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	IF (@fieldname=N'fldId')
	SELECT TOP(@h) [fldId], [fldNameCompany], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblExternalFish] 
	WHERE  fldId = @Value
    
	if (@fieldname=N'fldNameCompany')
	SELECT top(@h) [fldId], [fldNameCompany], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblExternalFish] 
	WHERE  fldNameCompany like @Value



	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldNameCompany], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblExternalFish] 

	COMMIT
GO
