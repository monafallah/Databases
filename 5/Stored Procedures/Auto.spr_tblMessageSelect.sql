SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMessageSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) m.[fldId], [fldCommisionId], [fldTitle], [fldMatn], m.[fldUserId], m.[fldDesc], m.[fldDate], m.[fldOrganId], m.[fldIP] 
	,fldTarikhShamsi
	FROM   [Auto].[tblMessage] m
	inner join [auto].tblCommision c on m.fldCommisionId=c.fldID
	WHERE  m.fldId=@Value and m.fldOrganId=@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) m.[fldId], [fldCommisionId], [fldTitle], [fldMatn], m.[fldUserId], m.[fldDesc], m.[fldDate], m.[fldOrganId], m.[fldIP] 
	,fldTarikhShamsi
	FROM   [Auto].[tblMessage] m
	inner join [auto].tblCommision c on m.fldCommisionId=c.fldID
	WHERE  m.fldDesc like @Value  and m.fldOrganId=@organId

	if (@FieldName='')
	SELECT top(@h) m.[fldId], [fldCommisionId], [fldTitle], [fldMatn], m.[fldUserId], m.[fldDesc], m.[fldDate], m.[fldOrganId], m.[fldIP] 
	,fldTarikhShamsi
	FROM   [Auto].[tblMessage] m
	inner join [auto].tblCommision c on m.fldCommisionId=c.fldID
	WHERE  m.fldOrganId=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) m.[fldId], [fldCommisionId], [fldTitle], [fldMatn], m.[fldUserId], m.[fldDesc], m.[fldDate], m.[fldOrganId], m.[fldIP] 
	,fldTarikhShamsi
	FROM   [Auto].[tblMessage] m
	inner join [auto].tblCommision c on m.fldCommisionId=c.fldID
	WHERE  m.fldOrganId=@organId
	
	COMMIT
GO
