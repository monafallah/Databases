SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblFormatShomareNameSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	 set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT TOP (@h) fldId, fldYear, fldFormatShomareName, fldShomareShoro, fldUserId, fldDesc, fldDate, fldType,CASE WHEN fldType=0 THEN N'مکاتبات' WHEN fldType=1 THEN N'رسید به مؤدی' END AS typeName
FROM     Drd.tblFormatShomareName
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldYear], [fldFormatShomareName], [fldShomareShoro], [fldUserId], [fldDesc], [fldDate] , fldType,CASE WHEN fldType=0 THEN N'مکاتبات' WHEN fldType=1 THEN N'رسید به مؤدی' END AS typeName
	FROM   [Drd].[tblFormatShomareName] 
	WHERE  fldYear like @Value
	
	if (@fieldname=N'fldFormatShomareName')
	SELECT top(@h) [fldId], [fldYear], [fldFormatShomareName], [fldShomareShoro], [fldUserId], [fldDesc], [fldDate] , fldType,CASE WHEN fldType=0 THEN N'مکاتبات' WHEN fldType=1 THEN N'رسید به مؤدی' END AS typeName
	FROM   [Drd].[tblFormatShomareName] 
	WHERE  fldFormatShomareName like @Value
	
	if (@fieldname=N'fldShomareShoro')
	SELECT top(@h) [fldId], [fldYear], [fldFormatShomareName], [fldShomareShoro], [fldUserId], [fldDesc], [fldDate] , fldType,CASE WHEN fldType=0 THEN N'مکاتبات' WHEN fldType=1 THEN N'رسید به مؤدی' END AS typeName
	FROM   [Drd].[tblFormatShomareName] 
	WHERE  fldShomareShoro like @Value

	if (@fieldname=N'typeName')
	SELECT top(@h)* from(SELECT fldId, fldYear, fldFormatShomareName, fldShomareShoro, fldUserId, fldDesc, fldDate, fldType,CASE WHEN fldType=0 THEN N'مکاتبات' WHEN fldType=1 THEN N'رسید به مؤدی' END AS typeName
FROM     Drd.tblFormatShomareName)as t
	WHERE  typeName like @Value

	if (@fieldname=N'fldDesc')
	SELECT TOP (@h) fldId, fldYear, fldFormatShomareName, fldShomareShoro, fldUserId, fldDesc, fldDate, fldType,CASE WHEN fldType=0 THEN N'مکاتبات' WHEN fldType=1 THEN N'رسید به مؤدی' END AS typeName
FROM     Drd.tblFormatShomareName
	WHERE  fldDesc like @Value  

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldYear], [fldFormatShomareName], [fldShomareShoro], [fldUserId], [fldDesc], [fldDate] , fldType ,CASE WHEN fldType=0 THEN N'مکاتبات' WHEN fldType=1 THEN N'رسید به مؤدی' END AS typeName
	FROM   [Drd].[tblFormatShomareName] 

	COMMIT
GO
