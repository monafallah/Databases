SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAshkhaseHoghoghiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
    set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldShenaseMelli], [fldName], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate] 
	 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'شرکت داخلی' else N'شرکت خارجی' end as fldTypeShakhsName
	 ,fldSayer,CASE WHEN fldSayer=1 THEN N'حقوقی' WHEN fldSayer=2 THEN N'سایر' END AS fldSayerName
	FROM   [com].[tblAshkhaseHoghoghi] 
	WHERE  fldId = @Value
	ORDER BY fldId DESC

	if (@fieldname=N'fldShenaseMelli')
	SELECT top(@h) [fldId], [fldShenaseMelli], [fldName], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate] 
	 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'شرکت داخلی' else N'شرکت خارجی' end as fldTypeShakhsName
	 ,fldSayer,CASE WHEN fldSayer=1 THEN N'حقوقی' WHEN fldSayer=2 THEN N'سایر' END AS fldSayerName
	FROM   [com].[tblAshkhaseHoghoghi] 
	WHERE  fldShenaseMelli like @Value
	ORDER BY fldId DESC

	if (@fieldname=N'fldShomareSabt')
	SELECT top(@h) [fldId], [fldShenaseMelli], [fldName], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate] 
	 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'شرکت داخلی' else N'شرکت خارجی' end as fldTypeShakhsName
	 ,fldSayer,CASE WHEN fldSayer=1 THEN N'حقوقی' WHEN fldSayer=2 THEN N'سایر' END AS fldSayerName
	FROM   [com].[tblAshkhaseHoghoghi] 
	WHERE  fldShomareSabt like @Value
	ORDER BY fldId DESC

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldShenaseMelli], [fldName], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate] 
	 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'شرکت داخلی' else N'شرکت خارجی' end as fldTypeShakhsName
	 ,fldSayer,CASE WHEN fldSayer=1 THEN N'حقوقی' WHEN fldSayer=2 THEN N'سایر' END AS fldSayerName
	FROM   [com].[tblAshkhaseHoghoghi] 
	WHERE  fldDesc like @Value
	ORDER BY fldId DESC

	if (@fieldname=N'fldTypeShakhsName')
	SELECT top(@h) * FROM (SELECT [fldId], [fldShenaseMelli], [fldName], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate] 
	 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'شرکت داخلی' else N'شرکت خارجی' end as fldTypeShakhsName
	 ,fldSayer,CASE WHEN fldSayer=1 THEN N'حقوقی' WHEN fldSayer=2 THEN N'سایر' END AS fldSayerName
	FROM   [com].[tblAshkhaseHoghoghi] )AS t
	WHERE  fldTypeShakhsName like @Value
	ORDER BY fldId DESC
	
	if (@fieldname=N'fldSayerName')
	SELECT top(@h) * FROM (SELECT [fldId], [fldShenaseMelli], [fldName], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate] 
	 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'شرکت داخلی' else N'شرکت خارجی' end as fldTypeShakhsName
	 ,fldSayer,CASE WHEN fldSayer=1 THEN N'حقوقی' WHEN fldSayer=2 THEN N'سایر' END AS fldSayerName
	FROM   [com].[tblAshkhaseHoghoghi] )AS t
	WHERE  fldSayerName like @Value
	ORDER BY fldId DESC



	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldShenaseMelli], [fldName], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate] 
	 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'شرکت داخلی' else N'شرکت خارجی' end as fldTypeShakhsName
	 ,fldSayer,CASE WHEN fldSayer=1 THEN N'حقوقی' WHEN fldSayer=2 THEN N'سایر' END AS fldSayerName
	FROM   [com].[tblAshkhaseHoghoghi] 
	WHERE  fldName like @Value
	ORDER BY fldId DESC

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldShenaseMelli], [fldName], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate]
	 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'شرکت داخلی' else N'شرکت خارجی' end as fldTypeShakhsName 
	 ,fldSayer,CASE WHEN fldSayer=1 THEN N'حقوقی' WHEN fldSayer=2 THEN N'سایر' END AS fldSayerName
	FROM   [com].[tblAshkhaseHoghoghi] 
	ORDER BY fldId DESC

	COMMIT
GO
