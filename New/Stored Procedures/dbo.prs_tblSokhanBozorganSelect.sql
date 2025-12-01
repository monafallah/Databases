SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblSokhanBozorganSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldMoalef], [fldNaghlGhol] 
	FROM   [dbo].[tblSokhanBozorgan] 
	WHERE  fldId=@Value
	
	if (@FieldName='Random')
	SELECT top(1) [fldId], [fldMoalef], [fldNaghlGhol] 
	FROM   [dbo].[tblSokhanBozorgan] 
ORDER BY NEWID()

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldMoalef], [fldNaghlGhol] 
	FROM   [dbo].[tblSokhanBozorgan] 

	
	COMMIT
GO
