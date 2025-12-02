SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreOmoomiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldNameParametreFa], [fldNameParametreEn], [fldNoeField], [fldFormulId], [fldUserId], [fldDesc], [fldDate] , CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblParametreOmoomi] 
	WHERE  fldId = @Value

    if (@fieldname=N'fldNameParametreEn')
	SELECT top(@h) [fldId], [fldNameParametreFa], [fldNameParametreEn], [fldNoeField], [fldFormulId], [fldUserId], [fldDesc], [fldDate], CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName 
	FROM   [Drd].[tblParametreOmoomi] 
	WHERE  fldNameParametreEn like @Value


	  if (@fieldname=N'fldNameParametreFa')
	SELECT top(@h) [fldId], [fldNameParametreFa], [fldNameParametreEn], [fldNoeField], [fldFormulId], [fldUserId], [fldDesc], [fldDate], CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName 
	FROM   [Drd].[tblParametreOmoomi] 
	WHERE  fldNameParametreFa like @Value


	  if (@fieldname=N'NoeFieldName')
	SELECT top(@h)* from(select [fldId], [fldNameParametreFa], [fldNameParametreEn], [fldNoeField], [fldFormulId], [fldUserId], [fldDesc], [fldDate], CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName 
	FROM   [Drd].[tblParametreOmoomi] )as t
	WHERE  NoeFieldName like @Value


		if (@fieldname=N'fldFormulId')
	SELECT top(@h) [fldId], [fldNameParametreFa], [fldNameParametreEn], [fldNoeField], [fldFormulId], [fldUserId], [fldDesc], [fldDate] , CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblParametreOmoomi] 
	WHERE  fldFormulId = @Value


		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldNameParametreFa], [fldNameParametreEn], [fldNoeField], [fldFormulId], [fldUserId], [fldDesc], [fldDate] , CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblParametreOmoomi] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldNameParametreFa], [fldNameParametreEn], [fldNoeField], [fldFormulId], [fldUserId], [fldDesc], [fldDate], CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName 
	FROM   [Drd].[tblParametreOmoomi] 

	COMMIT
GO
