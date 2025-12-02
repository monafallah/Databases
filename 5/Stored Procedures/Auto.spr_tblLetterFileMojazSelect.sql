SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterFileMojazSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h)[tblLetterFileMojaz]. [fldId], [fldFormatFileId],[tblLetterFileMojaz].fldType, [tblLetterFileMojaz].[fldUserId], [tblLetterFileMojaz].[fldDesc], [tblLetterFileMojaz].[fldDate], [tblLetterFileMojaz].[fldOrganId], [tblLetterFileMojaz].[fldIP] 
	, fldPassvand,fldSize
	,case when fldType=1 then N'نامه' when fldtype=2 then N'پیام' end as fldTypeName
	FROM   [Auto].[tblLetterFileMojaz] 
	inner join   com.tblFormatFile on tblFormatFile.fldid=fldFormatFileId
	WHERE  [tblLetterFileMojaz].fldId=@Value and [tblLetterFileMojaz].fldOrganId=@organId

	if (@FieldName='fldDesc')
SELECT top(@h)[tblLetterFileMojaz]. [fldId], [fldFormatFileId],[tblLetterFileMojaz].fldType, [tblLetterFileMojaz].[fldUserId], [tblLetterFileMojaz].[fldDesc], [tblLetterFileMojaz].[fldDate], [tblLetterFileMojaz].[fldOrganId], [tblLetterFileMojaz].[fldIP] 
	, fldPassvand,fldSize
	,case when fldType=1 then N'نامه' when fldtype=2 then N'پیام' end as fldTypeName
	FROM   [Auto].[tblLetterFileMojaz] 
	inner join   com.tblFormatFile on tblFormatFile.fldid=fldFormatFileId
	WHERE  [tblLetterFileMojaz].fldDesc like @Value and [tblLetterFileMojaz].fldOrganId=@organId

	
	if (@FieldName='fldPassvand')
SELECT top(@h)[tblLetterFileMojaz]. [fldId], [fldFormatFileId],[tblLetterFileMojaz].fldType, [tblLetterFileMojaz].[fldUserId], [tblLetterFileMojaz].[fldDesc], [tblLetterFileMojaz].[fldDate], [tblLetterFileMojaz].[fldOrganId], [tblLetterFileMojaz].[fldIP] 
	, fldPassvand,fldSize
	,case when fldType=1 then N'نامه' when fldtype=2 then N'پیام' end as fldTypeName
	FROM   [Auto].[tblLetterFileMojaz] 
	inner join   com.tblFormatFile on tblFormatFile.fldid=fldFormatFileId
	WHERE  fldPassvand like @Value and [tblLetterFileMojaz]. fldOrganId=@organId

	if (@FieldName='')
	SELECT top(@h)[tblLetterFileMojaz]. [fldId], [fldFormatFileId],[tblLetterFileMojaz].fldType, [tblLetterFileMojaz].[fldUserId], [tblLetterFileMojaz].[fldDesc], [tblLetterFileMojaz].[fldDate], [tblLetterFileMojaz].[fldOrganId], [tblLetterFileMojaz].[fldIP] 
	, fldPassvand,fldSize
	,case when fldType=1 then N'نامه' when fldtype=2 then N'پیام' end as fldTypeName
	FROM   [Auto].[tblLetterFileMojaz] 
	inner join   com.tblFormatFile on tblFormatFile.fldid=fldFormatFileId 
	where  [tblLetterFileMojaz].fldOrganId=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h)[tblLetterFileMojaz]. [fldId], [fldFormatFileId],[tblLetterFileMojaz].fldType, [tblLetterFileMojaz].[fldUserId], [tblLetterFileMojaz].[fldDesc], [tblLetterFileMojaz].[fldDate], [tblLetterFileMojaz].[fldOrganId], [tblLetterFileMojaz].[fldIP] 
	, fldPassvand,fldSize
	,case when fldType=1 then N'نامه' when fldtype=2 then N'پیام' end as fldTypeName
	FROM   [Auto].[tblLetterFileMojaz] 
	inner join   com.tblFormatFile on tblFormatFile.fldid=fldFormatFileId
	where [tblLetterFileMojaz]. fldOrganId=@organId
	
	COMMIT
GO
