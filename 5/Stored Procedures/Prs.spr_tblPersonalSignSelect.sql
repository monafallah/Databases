SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPersonalSignSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], fldCommitionId, [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast (0 as bit)fldIsEdit
 	FROM   [Prs].[tblPersonalSign] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], fldCommitionId, [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast (0 as bit)fldIsEdit
	FROM   [Prs].[tblPersonalSign] 
	WHERE  fldDesc like @Value

	if (@FieldName='fldCommitionId')
	SELECT top(1) [fldId], fldCommitionId, [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,case when Tedad>1 then cast(1 as bit) else cast(0 as bit) end AS fldIsEdit
	FROM   [Prs].[tblPersonalSign] 
	outer apply (select count(*)Tedad from [Prs].[tblPersonalSign] s
					where s.fldCommitionId=[Prs].[tblPersonalSign] .fldCommitionId
					)Edit

	WHERE  fldCommitionId like @Value
	order by fldId desc


	if (@FieldName='fldFileId')
	SELECT top(@h) [fldId], fldCommitionId, [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast (0 as bit)fldIsEdit
	FROM   [Prs].[tblPersonalSign] 
	WHERE  fldFileId like @Value


	if (@FieldName='')
	SELECT top(@h) [fldId], fldCommitionId, [fldFileId], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	,cast (0 as bit)fldIsEdit
	FROM   [Prs].[tblPersonalSign] 

	
	COMMIT
GO
