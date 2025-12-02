SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMaliyatArzesheAfzoodeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	declare @Tarikh NVARCHAR(10)
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldFromDate')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  fldFromDate like @Value

    if (@fieldname=N'fldEndDate')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  fldEndDate like @Value


	if (@fieldname=N'fldFromDateToEndDate')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  @Value BETWEEN fldFromDate AND fldEndDate

	if (@fieldname=N'LastFromDateToEndDate')
	begin
	SET @Tarikh=dbo.Fn_AssembelyMiladiToShamsi(GETDATE())
	SELECT top(1) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  @Tarikh BETWEEN fldFromDate AND fldEndDate
	order by fldid desc
	end
	if (@fieldname=N'fldDarsadeAvarez')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  fldDarsadeAvarez like @Value
	  
	if (@fieldname=N'fldDarsadeMaliyat')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  fldDarsadeMaliyat like @Value

	if (@fieldname=N'fldDarsadAmuzeshParvaresh')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  fldDarsadAmuzeshParvaresh like @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldFromDate], [fldEndDate], [fldDarsadeAvarez], [fldDarsadeMaliyat], [fldUserId], [fldDesc], [fldDate] 
	,fldDarsadAmuzeshParvaresh
	FROM   [com].[tblMaliyatArzesheAfzoode] 

	COMMIT
GO
