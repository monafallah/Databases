SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblFileDesktop_UserSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldThem] as fldFileDesktop, [fldPasvand], [fldSize], [fldFileName] 
	FROM   [dbo].[tblFileDesktop_User] 
	WHERE  fldId=@Value

	

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldThem] as fldFileDesktop, [fldPasvand], [fldSize], [fldFileName] 
	FROM   [dbo].[tblFileDesktop_User] 

	
	COMMIT
GO
