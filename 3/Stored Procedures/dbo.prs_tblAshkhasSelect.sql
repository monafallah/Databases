SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblAshkhasSelect] 
@FieldName nvarchar(50),
@Value nvarchar(300),
@valueBinary varbinary(300),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) a.[fldId], [fldName], [fldFamily], [fldFatherName], 
	[fldCodeMeli], [fldEmail], [fldMobile], [fldFileId], [fldDesc], [fldSh_Shenasname], 
	[fldCodeMahalTavalod], [fldCodeMahalSodoor], [fldJensiyat], format([fldTarikhTavalod],'####/##/##')fldTarikhTavalod,
	 cast(a.[fldTimeStamp] as int)fldTimeStamp
	 ,c.fldnameCity as fldNameTavalod,c1.fldnameCity as fldNameSodoor
	FROM   [dbo].[tblAshkhas] a left join tblcity c 
	on fldCodeMahalTavalod=c.fldid 
	left join tblcity c1 on fldCodeMahalSodoor=c1.fldid
	WHERE  a.fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) a.[fldId], [fldName], [fldFamily], [fldFatherName], 
	[fldCodeMeli], [fldEmail], [fldMobile], [fldFileId], [fldDesc], [fldSh_Shenasname], 
	[fldCodeMahalTavalod], [fldCodeMahalSodoor], [fldJensiyat], format([fldTarikhTavalod],'####/##/##')fldTarikhTavalod,
	 cast(a.[fldTimeStamp] as int)fldTimeStamp
	 ,c.fldnameCity as fldNameTavalod,c1.fldnameCity as fldNameSodoor
	FROM   [dbo].[tblAshkhas] a left join tblcity c 
	on fldCodeMahalTavalod=c.fldid 
	left join tblcity c1 on fldCodeMahalSodoor=c1.fldid
	WHERE  fldDesc=@Value

	if (@FieldName='')
	SELECT top(@h) a.[fldId], [fldName], [fldFamily], [fldFatherName], 
	[fldCodeMeli], [fldEmail], [fldMobile], [fldFileId], [fldDesc], [fldSh_Shenasname], 
	[fldCodeMahalTavalod], [fldCodeMahalSodoor], [fldJensiyat], format([fldTarikhTavalod],'####/##/##')fldTarikhTavalod,
	 cast(a.[fldTimeStamp] as int)fldTimeStamp
	 ,c.fldnameCity as fldNameTavalod,c1.fldnameCity as fldNameSodoor
	FROM   [dbo].[tblAshkhas] a left join tblcity c 
	on fldCodeMahalTavalod=c.fldid 
	left join tblcity c1 on fldCodeMahalSodoor=c1.fldid
	
	COMMIT
GO
