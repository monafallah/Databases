SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_tblFileBlockListSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldType] 
	FROM   [dbo].[tblFileBlockList] 
	WHERE  fldId=@Value

	if (@FieldName='fldType')
	SELECT top(@h) [fldId], [fldType] 
	FROM   [dbo].[tblFileBlockList] 
	WHERE  fldType like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldType] 
	FROM   [dbo].[tblFileBlockList] 

	
	COMMIT
GO
