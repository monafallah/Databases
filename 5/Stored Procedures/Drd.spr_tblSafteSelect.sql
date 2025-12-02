SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSafteSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldTarikhSarResid], [fldShomareSanad],fldReplyTaghsitId ,CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, [fldStatus], [fldUserId], [fldDesc], [fldDate] 
		,CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' when fldStatus=5 THEN N'عودت داده شده' END AS fldStatusName
	FROM   [Drd].[tblSafte] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldTarikhSarResid], [fldShomareSanad],fldReplyTaghsitId ,CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, [fldStatus], [fldUserId], [fldDesc], [fldDate] 
		,CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' when fldStatus=5 THEN N'عودت داده شده' END AS fldStatusName
	FROM   [Drd].[tblSafte] 
	WHERE  fldDesc like @Value

if (@fieldname=N'fldShomareSanad')
	SELECT top(@h) [fldId], [fldTarikhSarResid], [fldShomareSanad],fldReplyTaghsitId ,CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, [fldStatus], [fldUserId], [fldDesc], [fldDate] 
		,CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' when fldStatus=5 THEN N'عودت داده شده' END AS fldStatusName
	FROM   [Drd].[tblSafte] 
	WHERE  fldShomareSanad like @Value 

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldTarikhSarResid], [fldShomareSanad],fldReplyTaghsitId ,CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, [fldStatus], [fldUserId], [fldDesc], [fldDate] 
		,CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' when fldStatus=5 THEN N'عودت داده شده' END AS fldStatusName

	FROM   [Drd].[tblSafte] 

	COMMIT
GO
