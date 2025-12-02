SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMahdoodiyatMohasebatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN

	SET @value=com.fn_TextNormalize(@value) 
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] 
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldAzTarikh')
	SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] 
	WHERE  fldAzTarikh like @Value
	
	if (@fieldname=N'fldTatarikh')
	SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] 
	WHERE  fldTatarikh like @Value
	
	if (@fieldname=N'fldTarikh')
	SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] 
	WHERE @Value BETWEEN fldAzTarikh AND fldTatarikh AND fldStatus=1

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'fldNoeKarbarName')
	select * from(SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] )temp
	WHERE fldNoeKarbarName like  @Value

		if (@fieldname=N'fldNoeCodeDaramadName')
	select * from(SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] )temp
	WHERE fldNoeCodeDaramadName like  @Value

		if (@fieldname=N'fldNoeAshkhasName')
	select * from(SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] )temp
	WHERE fldNoeAshkhasName like  @Value

		if (@fieldname=N'fldStatusName')
	select * from(SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] )temp
	WHERE fldStatusName like  @Value
	
	if (@fieldname=N'UserId')
	BEGIN
	DECLARE @t NVARCHAR(10)
	SET @t=dbo.Fn_AssembelyMiladiToShamsi(GETDATE())
	SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] 
	WHERE fldStatus=1 AND @t BETWEEN fldAzTarikh AND fldTatarikh AND (fldNoeKarbar=1 OR (fldNoeKarbar=0 AND fldid IN (SELECT fldMahdoodiyatMohasebatId FROM tblMohdoodiyatMohasebat WHERE fldIdUser=@value)))
	end

	if (@fieldname=N'')
	SELECT top(@h) [fldId],fldTitle, [fldAzTarikh], [fldTatarikh], [fldNoeKarbar], [fldNoeCodeDaramad], [fldNoeAshkhas], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldNoeKarbar=1 THEN N'همه' ELSE N'کاربران خاص' END AS fldNoeKarbarName
	,CASE WHEN fldNoeCodeDaramad=1 THEN N'همه' ELSE N'کدهای درآمد خاص' END AS fldNoeCodeDaramadName
	,CASE WHEN fldNoeAshkhas=1 THEN N'همه' ELSE N'اشخاص خاص' END AS fldNoeAshkhasName
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName
	FROM   [Drd].[tblMahdoodiyatMohasebat] 

	COMMIT
GO
