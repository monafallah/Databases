SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblTypeKhodroSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Com].[tblTypeKhodro] 
	WHERE  fldId=@Value
	order by fldorder 
	 
	if (@FieldName='fldName')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Com].[tblTypeKhodro] 
	WHERE  fldName like @Value
	order by fldorder 

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP] 
	FROM   [Com].[tblTypeKhodro] 
	order by fldorder 
	
	COMMIT
GO
