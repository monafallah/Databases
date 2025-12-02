SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPatternFishSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId],fldName, [fldFileId],[fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId],fldName, [fldFileId],[fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish] 
	WHERE fldDesc like  @Value
	
	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId],fldName, [fldFileId],[fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish] 
	WHERE fldName like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId],fldName, [fldFileId],[fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish] 

	COMMIT
GO
