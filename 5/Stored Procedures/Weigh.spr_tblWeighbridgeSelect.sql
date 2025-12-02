SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblWeighbridgeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),

@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid
	WHERE  w.fldId=@Value 

	if (@FieldName='fldDesc')
		SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid 
	WHERE  w.fldDesc like @Value 


	if (@FieldName='fldAshkhasHoghoghiId')
		SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid 
	WHERE  w.fldAshkhasHoghoghiId like @Value 


	if (@FieldName='fldNameAshkhasHoghoghi')
		SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid 
	WHERE  tblAshkhaseHoghoghi.fldName like @Value 

		if (@FieldName='fldName')
		SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid 
	WHERE  w.fldName like @Value 

		if (@FieldName='fldAddress')
		SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid 
	WHERE  w.fldAddress like @Value
	
		if (@FieldName='fldShenaseMelli')
		SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid 
	WHERE  fldShenaseMelli like @Value 

	if (@FieldName='fldPassword')
		SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid 
	WHERE  fldPassword like @Value 

	if (@FieldName='')
	SELECT top(@h) w.[fldId], [fldAshkhasHoghoghiId], w.[fldName], [fldAddress], w.[fldUserId],
	 w.[fldDesc], w.[fldDate], [fldIP] ,tblAshkhaseHoghoghi.fldName as fldNameAshkhasHoghoghi
	,fldShenaseMelli,fldPassword
	FROM   [Weigh].[tblWeighbridge] w inner join com.tblAshkhaseHoghoghi 
	on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid

	
	COMMIT
GO
