SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblTypeEstekhdam_FormulSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblTypeEstekhdam_Formul] 
	WHERE  fldId=@Value

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblTypeEstekhdam_Formul] 
	WHERE  fldDesc like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblTypeEstekhdam_Formul] 

	
	COMMIT
GO
