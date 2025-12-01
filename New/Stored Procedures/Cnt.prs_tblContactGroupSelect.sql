SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContactGroupSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [tblContactGroup].[fldId], [fldNameGroup], [fldUserId],cast ( [fldTimeStamp] as int)fldTimeStamp
	FROM   [Cnt].[tblContactGroup] 
	WHERE  [tblContactGroup].fldId=@Value

	if (@FieldName='fldNameGroup')
	SELECT top(@h) [tblContactGroup].[fldId], [fldNameGroup], [fldUserId],cast ( [fldTimeStamp] as int)fldTimeStamp
	FROM   [Cnt].[tblContactGroup] 
	WHERE  fldNameGroup like @Value
	
	if (@FieldName='')
	SELECT top(@h) [tblContactGroup].[fldId], [fldNameGroup], [fldUserId],cast ( [fldTimeStamp] as int)fldTimeStamp
	FROM   [Cnt].[tblContactGroup] 
	
	COMMIT
GO
