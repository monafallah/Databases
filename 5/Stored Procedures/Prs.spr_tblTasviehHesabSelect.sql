SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblTasviehHesabSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@Value2 nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblTasviehHesab] 
	WHERE  fldId=@Value

	if (@FieldName='fldPrsPersonalInfoId')
	SELECT top(@h) [fldId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblTasviehHesab] 
	WHERE  fldPrsPersonalInfoId=@Value2

	if (@FieldName='fldTarikh')
	SELECT top(@h) [fldId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblTasviehHesab] 
	WHERE  fldTarikh like @Value

	if (@FieldName='CheckPrsPersonalInfoId_Tarikh')
	SELECT top(@h) [fldId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblTasviehHesab] 
	WHERE    fldPrsPersonalInfoId=@Value and fldTarikh = @Value2

	if (@FieldName='MaxTarikhPrsPersonalInfoId')
	SELECT top(1) [fldId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblTasviehHesab] 
	WHERE    fldPrsPersonalInfoId=@Value 
	order by fldTarikh desc

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblTasviehHesab] 
	WHERE  fldDesc like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldPrsPersonalInfoId], [fldTarikh], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Prs].[tblTasviehHesab] 

	
	COMMIT
GO
