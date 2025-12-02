SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterTabagheBandiSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) lt.[fldId], [fldTabagheBandiId], [fldLetterId], [fldMessageId], lt.[fldUserId], lt.[fldOrganId], lt.[fldDesc],lt. [fldIP], lt.[fldDate] 
	,tbltabagheBandi.fldName as fldNameTabagheBandi,m.fldTitle as fldTitleMessage
	FROM   [Auto].[tblLetterTabagheBandi]lt inner join 
	auto.tbltabagheBandi on fldTabagheBandiId=tbltabagheBandi.fldid
	outer apply (select * from auto.tblMessage m where m.fldid=fldMessageId)m
	WHERE  lt.fldId=@Value and lt.fldOrganId=@OrganId

	if (@FieldName='fldDesc')
		SELECT top(@h) lt.[fldId], [fldTabagheBandiId], [fldLetterId], [fldMessageId], lt.[fldUserId], lt.[fldOrganId], lt.[fldDesc],lt. [fldIP], lt.[fldDate] 
	,tbltabagheBandi.fldName as fldNameTabagheBandi,m.fldTitle as fldTitleMessage
	FROM   [Auto].[tblLetterTabagheBandi]lt inner join 
	auto.tbltabagheBandi on fldTabagheBandiId=tbltabagheBandi.fldid
	outer apply (select * from auto.tblMessage m where m.fldid=fldMessageId)m
	WHERE  lt.fldDesc like @Value  and lt.fldOrganId=@OrganId

	if (@FieldName='fldTabagheBandiId')
		SELECT top(@h) lt.[fldId], [fldTabagheBandiId], [fldLetterId], [fldMessageId], lt.[fldUserId], lt.[fldOrganId], lt.[fldDesc],lt. [fldIP], lt.[fldDate] 
	,tbltabagheBandi.fldName as fldNameTabagheBandi,m.fldTitle as fldTitleMessage
	FROM   [Auto].[tblLetterTabagheBandi]lt inner join 
	auto.tbltabagheBandi on fldTabagheBandiId=tbltabagheBandi.fldid
	outer apply (select * from auto.tblMessage m where m.fldid=fldMessageId)m
	WHERE  lt.fldTabagheBandiId like @Value  and lt.fldOrganId=@OrganId

	if (@FieldName='fldLetterId')
		SELECT top(@h) lt.[fldId], [fldTabagheBandiId], [fldLetterId], [fldMessageId], lt.[fldUserId], lt.[fldOrganId], lt.[fldDesc],lt. [fldIP], lt.[fldDate] 
	,tbltabagheBandi.fldName as fldNameTabagheBandi,m.fldTitle as fldTitleMessage
	FROM   [Auto].[tblLetterTabagheBandi]lt inner join 
	auto.tbltabagheBandi on fldTabagheBandiId=tbltabagheBandi.fldid
	outer apply (select * from auto.tblMessage m where m.fldid=fldMessageId)m
	WHERE  lt.fldLetterId like @Value  and lt.fldOrganId=@OrganId

	if (@FieldName='fldMessageId')
		SELECT top(@h) lt.[fldId], [fldTabagheBandiId], [fldLetterId], [fldMessageId], lt.[fldUserId], lt.[fldOrganId], lt.[fldDesc],lt. [fldIP], lt.[fldDate] 
	,tbltabagheBandi.fldName as fldNameTabagheBandi,m.fldTitle as fldTitleMessage
	FROM   [Auto].[tblLetterTabagheBandi]lt inner join 
	auto.tbltabagheBandi on fldTabagheBandiId=tbltabagheBandi.fldid
	outer apply (select * from auto.tblMessage m where m.fldid=fldMessageId)m
	WHERE  lt.fldMessageId like @Value  and lt.fldOrganId=@OrganId

	if (@FieldName='')
		SELECT top(@h) lt.[fldId], [fldTabagheBandiId], [fldLetterId], [fldMessageId], lt.[fldUserId], lt.[fldOrganId], lt.[fldDesc],lt. [fldIP], lt.[fldDate] 
	,tbltabagheBandi.fldName as fldNameTabagheBandi,m.fldTitle as fldTitleMessage
	FROM   [Auto].[tblLetterTabagheBandi]lt inner join 
	auto.tbltabagheBandi on fldTabagheBandiId=tbltabagheBandi.fldid
	outer apply (select * from auto.tblMessage m where m.fldid=fldMessageId)m
	where   lt.fldOrganId=@OrganId

	if (@FieldName='fldOrganId')
		SELECT top(@h) lt.[fldId], [fldTabagheBandiId], [fldLetterId], [fldMessageId], lt.[fldUserId], lt.[fldOrganId], lt.[fldDesc],lt. [fldIP], lt.[fldDate] 
	,tbltabagheBandi.fldName as fldNameTabagheBandi,m.fldTitle as fldTitleMessage
	FROM   [Auto].[tblLetterTabagheBandi]lt inner join 
	auto.tbltabagheBandi on fldTabagheBandiId=tbltabagheBandi.fldid
	outer apply (select * from auto.tblMessage m where m.fldid=fldMessageId)m
	where   lt.fldOrganId=@OrganId

	
	COMMIT
GO
