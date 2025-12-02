SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblBudgetTypeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),

@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldTitle]
	FROM   [BUD].[tblBudgetType] 
	WHERE  fldId=@Value

	if (@FieldName='fldTitle')
	SELECT top(@h) [fldId], [fldTitle]
	FROM   [BUD].[tblBudgetType] 
	WHERE  fldTitle like @Value


	if (@FieldName='')
	SELECT top(@h) [fldId], [fldTitle]
	FROM   [BUD].[tblBudgetType] 

	COMMIT
GO
