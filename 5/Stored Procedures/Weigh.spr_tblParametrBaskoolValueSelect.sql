SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblParametrBaskoolValueSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),

@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldParametrBaskoolId], [fldBaskoolId], [fldValue], [fldUserId] , [fldDesc], [fldDate], [fldIP] 
	FROM   [Weigh].[tblParametrBaskoolValue] 
	WHERE  fldId=@Value  

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldParametrBaskoolId], [fldBaskoolId], [fldValue], [fldUserId] , [fldDesc], [fldDate], [fldIP] 
	FROM   [Weigh].[tblParametrBaskoolValue] 
	WHERE  fldDesc like @Value  


	if (@FieldName='fldBaskoolId')
	SELECT top(@h) [fldId], [fldParametrBaskoolId], [fldBaskoolId], [fldValue], [fldUserId] , [fldDesc], [fldDate], [fldIP] 
	FROM   [Weigh].[tblParametrBaskoolValue] 
	WHERE  fldBaskoolId like @Value  


	if (@FieldName='')
	SELECT top(@h) [fldId], [fldParametrBaskoolId], [fldBaskoolId], [fldValue], [fldUserId] , [fldDesc], [fldDate], [fldIP] 
	FROM   [Weigh].[tblParametrBaskoolValue] 

	
	COMMIT
GO
