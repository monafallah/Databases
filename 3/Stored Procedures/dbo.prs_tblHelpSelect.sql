SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [dbo].[prs_tblHelpSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], fldFormName, fldFilePdfId,fldFileVideoId,fldDesc
	FROM   [dbo].[tblHelp] 
	WHERE  fldId=@Value

	if (@FieldName='fldFormName')
	SELECT top(@h) [fldId], fldFormName, fldFilePdfId,fldFileVideoId,fldDesc
	FROM   [dbo].[tblHelp] 
	WHERE  fldFormName like @Value
	
	if (@FieldName='')
	SELECT top(@h) [fldId], fldFormName, fldFilePdfId,fldFileVideoId,fldDesc
	FROM   [dbo].[tblHelp] 
	
	COMMIT
GO
