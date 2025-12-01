SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContanctTypeSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [tblContanctType].[fldId], [fldType], [fldIconId], [fldFormul], [fldFormulId], cast([fldTimeStamp] as int) fldTimeStamp,fldFile
	
	FROM   [Cnt].[tblContanctType] 
	inner join tblFile on tblFile.fldId=fldIconId
	WHERE  [tblContanctType].fldId=@Value

	if (@FieldName='fldType')
	SELECT top(@h) [tblContanctType].[fldId], [fldType], [fldIconId], [fldFormul], [fldFormulId], cast([fldTimeStamp] as int) fldTimeStamp,fldFile
	
	FROM   [Cnt].[tblContanctType] 
	inner join tblFile on tblFile.fldId=fldIconId
	WHERE  fldType like @Value

	if (@FieldName='')
	SELECT top(@h) [tblContanctType].[fldId], [fldType], [fldIconId], [fldFormul], [fldFormulId], cast([fldTimeStamp] as int) fldTimeStamp,fldFile
	
	FROM   [Cnt].[tblContanctType] 
	inner join tblFile on tblFile.fldId=fldIconId
	
	COMMIT
GO
