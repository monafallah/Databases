SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblExternalLetterReceiverSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) e.[fldId], [fldLetterId], [fldMessageId], /*[fldAshkhasHoghoghiId],*/e. [fldDate], e.[fldOrganId],e. [fldUserId],e. [fldDesc], e.[fldIP] 
	--,tblAshkhaseHoghoghi.fldName as fldNameHoghoghi
	,t.fldname as fldNameHoghoghititles,fldHoghoghiTitlesId
	FROM   [Auto].[tblExternalLetterReceiver] e
	--inner join com.tblAshkhaseHoghoghi on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid
	inner join auto.tblAshkhaseHoghoghiTitles t on t.fldid=fldHoghoghiTitlesId
	WHERE  e.fldId=@Value and e.[fldOrganId]=@organId

	if (@FieldName='fldDesc')
SELECT top(@h)  e.[fldId], [fldLetterId], [fldMessageId], /*[fldAshkhasHoghoghiId],*/e. [fldDate], e.[fldOrganId],e. [fldUserId],e. [fldDesc], e.[fldIP] 
	--,tblAshkhaseHoghoghi.fldName as fldNameHoghoghi
	,t.fldname as fldNameHoghoghititles,fldHoghoghiTitlesId
	FROM   [Auto].[tblExternalLetterReceiver] e
	--inner join com.tblAshkhaseHoghoghi on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid
	inner join auto.tblAshkhaseHoghoghiTitles t on t.fldid=fldHoghoghiTitlesId
	WHERE  e.fldDesc like @Value and e.[fldOrganId]=@organId

	if (@FieldName='fldLetterID')
	SELECT top(@h)  e.[fldId], [fldLetterId], [fldMessageId], /*[fldAshkhasHoghoghiId],*/e. [fldDate], e.[fldOrganId],e. [fldUserId],e. [fldDesc], e.[fldIP] 
	--,tblAshkhaseHoghoghi.fldName as fldNameHoghoghi
	,t.fldname as fldNameHoghoghititles,fldHoghoghiTitlesId
	FROM   [Auto].[tblExternalLetterReceiver] e
	--inner join com.tblAshkhaseHoghoghi on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid
	inner join auto.tblAshkhaseHoghoghiTitles t on t.fldid=fldHoghoghiTitlesId
	WHERE  fldLetterID like @Value and e.[fldOrganId]=@organId


if (@FieldName='fldMessageId')
	SELECT top(@h)  e.[fldId], [fldLetterId], [fldMessageId], /*[fldAshkhasHoghoghiId],*/e. [fldDate], e.[fldOrganId],e. [fldUserId],e. [fldDesc], e.[fldIP] 
	--,tblAshkhaseHoghoghi.fldName as fldNameHoghoghi
	,t.fldname as fldNameHoghoghititles,fldHoghoghiTitlesId
	FROM   [Auto].[tblExternalLetterReceiver] e
	--inner join com.tblAshkhaseHoghoghi on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid
	inner join auto.tblAshkhaseHoghoghiTitles t on t.fldid=fldHoghoghiTitlesId
	WHERE  fldMessageId like @Value and e.[fldOrganId]=@organId

	if (@FieldName='fldOrganId')
SELECT top(@h) e.[fldId], [fldLetterId], [fldMessageId], /*[fldAshkhasHoghoghiId],*/e. [fldDate], e.[fldOrganId],e. [fldUserId],e. [fldDesc], e.[fldIP] 
	--,tblAshkhaseHoghoghi.fldName as fldNameHoghoghi
	,t.fldname as fldNameHoghoghititles,fldHoghoghiTitlesId
	FROM   [Auto].[tblExternalLetterReceiver] e
	--inner join com.tblAshkhaseHoghoghi on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid
	inner join auto.tblAshkhaseHoghoghiTitles t on t.fldid=fldHoghoghiTitlesId
	where  e.[fldOrganId]=@organId

	if (@FieldName='')
SELECT top(@h)  e.[fldId], [fldLetterId], [fldMessageId], /*[fldAshkhasHoghoghiId],*/e. [fldDate], e.[fldOrganId],e. [fldUserId],e. [fldDesc], e.[fldIP] 
	--,tblAshkhaseHoghoghi.fldName as fldNameHoghoghi
	,t.fldname as fldNameHoghoghititles,fldHoghoghiTitlesId
	FROM   [Auto].[tblExternalLetterReceiver] e
	--inner join com.tblAshkhaseHoghoghi on fldAshkhasHoghoghiId=tblAshkhaseHoghoghi.fldid
	inner join auto.tblAshkhaseHoghoghiTitles t on t.fldid=fldHoghoghiTitlesId
	where  e.[fldOrganId]=@organId

	
	COMMIT
GO
