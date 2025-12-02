SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblParametrsBaskoolSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),

@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldEnName], [fldFaName], [fldUserId] , [fldDesc], [fldDate], [fldIP] 
	FROM   [Weigh].[tblParametrsBaskool] 
	WHERE  fldId=@Value  

	if (@FieldName='fldEnName')
	SELECT top(@h) [fldId], [fldEnName], [fldFaName], [fldUserId] , [fldDesc], [fldDate], [fldIP] 
	FROM   [Weigh].[tblParametrsBaskool] 
	WHERE  fldEnName like @Value   

	
	if (@FieldName='fldFaName')
	SELECT top(@h) [fldId], [fldEnName], [fldFaName], [fldUserId] , [fldDesc], [fldDate], [fldIP] 
	FROM   [Weigh].[tblParametrsBaskool] 
	WHERE  fldFaName like @Value   



	if (@FieldName='')
	SELECT top(@h) [fldId], [fldEnName], [fldFaName], [fldUserId] , [fldDesc], [fldDate], [fldIP] 
	FROM   [Weigh].[tblParametrsBaskool] 

	
	COMMIT
GO
