SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPatternFish_DaramadGroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPatternFishId], [fldDaramadGroupId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish_DaramadGroup] 
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldDaramadGroupId')
	SELECT top(@h) [fldId], [fldPatternFishId], [fldDaramadGroupId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish_DaramadGroup] 
	WHERE  fldDaramadGroupId = @Value
	
	if (@fieldname=N'fldPatternFishId')
	SELECT top(@h) [fldId], [fldPatternFishId], [fldDaramadGroupId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish_DaramadGroup] 
	WHERE  fldPatternFishId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPatternFishId], [fldDaramadGroupId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish_DaramadGroup] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPatternFishId], [fldDaramadGroupId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblPatternFish_DaramadGroup] 

	COMMIT
GO
