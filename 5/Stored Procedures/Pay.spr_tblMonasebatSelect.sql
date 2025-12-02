SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@value2 nvarchar(50),
@DateType bit,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId
	WHERE  m.fldId=@value
	
	if (@fieldname='fldNameMonasebat')
	SELECT top(@h)m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId
	WHERE  m.fldNameMonasebat like @value

		if (@fieldname='fldHoliday')
	SELECT top(@h)m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId
	WHERE  m.fldHoliday = @value

		if (@fieldname='fldMazaya')
	SELECT top(@h)m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId
	WHERE  m.fldMazaya = @value


	if (@fieldname='fldNameType')
	SELECT top(@h)m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId
	WHERE t.fldName like @value

	if (@fieldname='fldDateTypeName')
	SELECT top(@h) * from (select m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId)t
	WHERE t.fldDateTypeName like @value

		if (@fieldname='fldHolidayName')
	SELECT top(@h) * from (select m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId)t
	WHERE t.fldHolidayName like @value

		if (@fieldname='fldMazayaName')
	SELECT top(@h) * from (select m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId)t
	WHERE t.fldMazayaName like @value


	if (@fieldname='')
SELECT top(@h)m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId

	if (@fieldname='CheckMonasebat')
	SELECT top(@h)m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName,''AS fldTarikh
	FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId
	WHERE  m.fldMonth = @value and m.fldDay=@value2 and m.fldDateType=@DateType
	
	if (@fieldname=N'DateShamsi')/*با بقیه فرق داره*/
	BEGIN
	DECLARE @YearIslamic int='',@Month INT='',@Islamic NVARCHAR(10),@Day NVARCHAR(2)=''
		SELECT @Islamic=dbo.UDateConvert_Persian2Islamic(@Value+'/01/01','/')
		SELECT @YearIslamic=Item FROM com.Split_Id(@Islamic,'/') WHERE Id=1
		SELECT @Month=Item FROM com.Split_Id(@Islamic,'/') WHERE Id=2
		SELECT @Day=Item FROM com.Split_Id(@Islamic,'/') WHERE Id=3

		SELECT top(@h)m.[fldId], [fldNameMonasebat], [fldMonasebatTypeId], m.[fldIP], m.[fldUserId], m.[fldDate] ,t.fldName as fldNameType
	,fldMonth	,fldDay	,fldDateType	,fldHoliday	,fldMazaya	
	,CASE WHEN fldDateType=1 THEN N'قمری' ELSE N'شمسی' END AS fldDateTypeName
	,CASE WHEN fldHoliday=1 THEN N'تعطیل' ELSE N'عادی' END AS fldHolidayName
	,CASE WHEN fldMazaya=1 THEN N'دارای مزایا' ELSE N'بدون مزایا' END AS fldMazayaName
		,CASE WHEN( fldDateType=0) THEN @Value+'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2))   
		WHEN fldDateType=1 AND @Month<fldMonth THEN  dbo.UDateConvert_Islamic2Persian((CAST(@YearIslamic AS NVARCHAR(4)) +'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2))),'/' )
		WHEN fldDateType=1 AND @Month>fldMonth THEN dbo.UDateConvert_Islamic2Persian((CAST(@YearIslamic+1 AS NVARCHAR(4)) +'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2)) ),'/' )
		WHEN fldDateType=1 AND @Month=fldMonth AND @Day<=fldDay THEN dbo.UDateConvert_Islamic2Persian((CAST(@YearIslamic AS NVARCHAR(4)) +'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2)) ),'/' )
		WHEN fldDateType=1 AND @Month=fldMonth AND @Day>fldDay THEN dbo.UDateConvert_Islamic2Persian((CAST(@YearIslamic+1 AS NVARCHAR(4)) +'/'+CAST( fldMonth AS NVARCHAR(2))+'/'+CAST(fldDay AS NVARCHAR(2)) ),'/' )END AS fldTarikh
		FROM   [Pay].[tblMonasebat]  as m	
	inner join pay.tblMonasebatType as t on t.fldId=m.fldMonasebatTypeId
					ORDER BY fldMonth,fldDay --DESC
	END 


	COMMIT
GO
