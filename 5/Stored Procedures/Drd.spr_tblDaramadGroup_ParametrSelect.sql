SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroup_ParametrSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName,fldNoeField,fldComboBoxId,fldFormuleId
	,CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblDaramadGroup_Parametr] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDaramadGroupId')
	SELECT top(@h) [fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName,fldNoeField,fldComboBoxId,fldFormuleId
	,CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblDaramadGroup_Parametr] 
	WHERE  fldDaramadGroupId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName,fldNoeField,fldComboBoxId,fldFormuleId
	,CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblDaramadGroup_Parametr] 
	WHERE fldDesc like  @Value
	
	if (@fieldname=N'fldEnName')
	SELECT top(@h) [fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName,fldNoeField,fldComboBoxId,fldFormuleId
	,CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblDaramadGroup_Parametr] 
	WHERE fldEnName like  @Value
	
		if (@fieldname=N'fldStatusName')
	SELECT top(@h)* FROM(select [fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName,fldNoeField,fldComboBoxId,fldFormuleId
	,CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblDaramadGroup_Parametr] )t
	WHERE fldStatusName like  @Value
	
	if (@fieldname=N'NoeFieldName')
	SELECT top(@h)* FROM (SELECT [fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName,fldNoeField,fldComboBoxId,fldFormuleId
	,CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblDaramadGroup_Parametr] )t
	WHERE NoeFieldName like  @Value
	
	if (@fieldname=N'fldFnName')
	SELECT top(@h) [fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName,fldNoeField,fldComboBoxId,fldFormuleId
	,CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblDaramadGroup_Parametr] 
	WHERE fldFnName like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldDaramadGroupId], [fldEnName], [fldFnName], [fldStatus], [fldUserId], [fldDesc], [fldDate] 
	,CASE WHEN fldStatus=1 THEN N'فعال' ELSE N'غیرفعال' END AS fldStatusName,fldNoeField,fldComboBoxId,fldFormuleId
	,CASE WHEN fldNoeField = 1 THEN N'صحیح' WHEN fldNoeField = 2 THEN N'اعشاری' WHEN fldNoeField = 3 THEN N'رشته' WHEN fldNoeField = 4 THEN N'تاریخ' WHEN fldNoeField = 5 THEN
                   'combobox' END AS NoeFieldName
	FROM   [Drd].[tblDaramadGroup_Parametr] 

	COMMIT
GO
