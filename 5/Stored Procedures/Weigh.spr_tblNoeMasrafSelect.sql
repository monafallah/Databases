SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblNoeMasrafSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldName] 
	FROM   [Weigh].[tblNoeMasraf] 
	WHERE  fldId=@Value

	if (@FieldName='fldName')
	SELECT top(@h) [fldId], [fldName] 
	FROM   [Weigh].[tblNoeMasraf] 
	WHERE  fldName like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldName] 
	FROM   [Weigh].[tblNoeMasraf] 

	
	COMMIT
GO
