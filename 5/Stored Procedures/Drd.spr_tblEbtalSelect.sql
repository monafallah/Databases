SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblEbtalSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldFishId], [fldRequestTaghsit_TakhfifId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblEbtal] 
	WHERE  fldId = @Value


    if (@fieldname=N'fldFishId')
	SELECT top(@h) [fldId], [fldFishId], [fldRequestTaghsit_TakhfifId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblEbtal] 
	WHERE  fldFishId = @Value


    if (@fieldname=N'fldRequestTaghsit_TakhfifId')
	SELECT top(@h) [fldId], [fldFishId], [fldRequestTaghsit_TakhfifId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblEbtal] 
	WHERE  fldRequestTaghsit_TakhfifId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldFishId], [fldRequestTaghsit_TakhfifId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblEbtal] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldFishId], [fldRequestTaghsit_TakhfifId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblEbtal] 

	COMMIT
GO
