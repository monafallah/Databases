SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingBudje_HeaderSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) h.[fldHedaerId],  h.[fldOrganId], h.[fldUserId], h.[fldDesc], h.[fldDate],h. [fldIP] 
	,fldYear
	FROM   [BUD].[tblCodingBudje_Header] h
	WHERE  h.[fldHedaerId]=@Value and h.fldOrganId=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) h.[fldHedaerId],  h.[fldOrganId], h.[fldUserId], h.[fldDesc], h.[fldDate],h. [fldIP] 
	,fldYear
	FROM   [BUD].[tblCodingBudje_Header] h
	WHERE  h.fldOrganId=@organId

	if (@FieldName='fldYear')
	SELECT top(@h) h.[fldHedaerId],  h.[fldOrganId], h.[fldUserId], h.[fldDesc], h.[fldDate],h. [fldIP] 
	,fldYear
	FROM   [BUD].[tblCodingBudje_Header] h
	WHERE  h.fldYear=@Value and h.fldOrganId=@organId

	if (@FieldName='fldDesc')
		SELECT top(@h) h.[fldHedaerId],  h.[fldOrganId], h.[fldUserId], h.[fldDesc], h.[fldDate],h. [fldIP] 
	,fldYear
	FROM   [BUD].[tblCodingBudje_Header] h
	WHERE  h.fldDesc like @Value

	if (@FieldName='')
	SELECT top(@h) h.[fldHedaerId],  h.[fldOrganId], h.[fldUserId], h.[fldDesc], h.[fldDate],h. [fldIP] 
	,fldYear
	FROM   [BUD].[tblCodingBudje_Header] h

	
	COMMIT
GO
