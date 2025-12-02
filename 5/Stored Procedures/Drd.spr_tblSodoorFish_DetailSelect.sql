SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSodoorFish_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldFishId], [fldCodeElamAvarezId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblSodoorFish_Detail] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldFishId')
	SELECT top(@h) [fldId], [fldFishId], [fldCodeElamAvarezId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblSodoorFish_Detail] 
	WHERE  fldFishId = @Value
	
		if (@fieldname=N'fldCodeElamAvarezId')
	SELECT top(@h) [fldId], [fldFishId], [fldCodeElamAvarezId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblSodoorFish_Detail] 
	WHERE  fldCodeElamAvarezId = @Value
	
	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldFishId], [fldCodeElamAvarezId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblSodoorFish_Detail] 
	WHERE  fldDesc like @Value
	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldFishId], [fldCodeElamAvarezId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblSodoorFish_Detail] 

	COMMIT
GO
