SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblPropertiesSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldNameFn],fldNameEn, [fldType], [fldFormulId], [fldUserId], [fldDesc], [fldDate] 
	,case when fldType=1 then N'عدد صحیح' when fldType=2 then N'عدد اعشاری' when fldType=3 then N'رشته'
	when fldType=1 then N'تاریخ'  end fldTypeName
	FROM   [Arch].[tblProperties] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldNameFn')
	SELECT top(@h) [fldId], [fldNameFn],fldNameEn, [fldType], [fldFormulId], [fldUserId], [fldDesc], [fldDate] 
	,case when fldType=1 then N'عدد صحیح' when fldType=2 then N'عدد اعشاری' when fldType=3 then N'رشته'
	when fldType=1 then N'تاریخ'  end fldTypeName
	FROM   [Arch].[tblProperties] 
	WHERE fldNameFn like  @Value

	if (@fieldname=N'fldNameEn')
	SELECT top(@h) [fldId], [fldNameFn],fldNameEn, [fldType], [fldFormulId], [fldUserId], [fldDesc], [fldDate] 
	,case when fldType=1 then N'عدد صحیح' when fldType=2 then N'عدد اعشاری' when fldType=3 then N'رشته'
	when fldType=1 then N'تاریخ'  end fldTypeName
	FROM   [Arch].[tblProperties] 
	WHERE fldNameEn like  @Value

	if (@fieldname=N'fldType')
	SELECT top(@h) [fldId], [fldNameFn],fldNameEn, [fldType], [fldFormulId], [fldUserId], [fldDesc], [fldDate] 
	,case when fldType=1 then N'عدد صحیح' when fldType=2 then N'عدد اعشاری' when fldType=3 then N'رشته'
	when fldType=1 then N'تاریخ'  end fldTypeName
	FROM   [Arch].[tblProperties] 
	WHERE fldType like  @Value

	if (@fieldname=N'fldType')
	select * from( SELECT top(@h) [fldId], [fldNameFn],fldNameEn, [fldType], [fldFormulId], [fldUserId], [fldDesc], [fldDate] 
	,case when fldType=1 then N'عدد صحیح' when fldType=2 then N'عدد اعشاری' when fldType=3 then N'رشته'
	when fldType=1 then N'تاریخ'  end fldTypeName
	FROM   [Arch].[tblProperties] )t
	WHERE t.fldTypeName like  @Value

	if (@fieldname=N'fldFormulId')
	SELECT top(@h) [fldId], [fldNameFn],fldNameEn, [fldType], [fldFormulId], [fldUserId], [fldDesc], [fldDate] 
	,case when fldType=1 then N'عدد صحیح' when fldType=2 then N'عدد اعشاری' when fldType=3 then N'رشته'
	when fldType=1 then N'تاریخ'  end fldTypeName
	FROM   [Arch].[tblProperties] 
	WHERE fldFormulId like  @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldNameFn],fldNameEn, [fldType], [fldFormulId], [fldUserId], [fldDesc], [fldDate] 
	,case when fldType=1 then N'عدد صحیح' when fldType=2 then N'عدد اعشاری' when fldType=3 then N'رشته'
	when fldType=1 then N'تاریخ'  end fldTypeName
	FROM   [Arch].[tblProperties] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldNameFn],fldNameEn, [fldType], [fldFormulId], [fldUserId], [fldDesc], [fldDate] 
	,case when fldType=1 then N'عدد صحیح' when fldType=2 then N'عدد اعشاری' when fldType=3 then N'رشته'
	when fldType=1 then N'تاریخ'  end fldTypeName
	FROM   [Arch].[tblProperties] 

	COMMIT
GO
