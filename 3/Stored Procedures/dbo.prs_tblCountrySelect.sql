SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblCountrySelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldNameCountry], cast([fldTimeStamp] as int)[fldTimeStamp]
	FROM   [dbo].[tblCountry] 
	WHERE  fldId=@Value

	if (@FieldName='fldNameCountry')
	SELECT top(@h) [fldId], [fldNameCountry], cast([fldTimeStamp] as int)[fldTimeStamp] 
	FROM   [dbo].[tblCountry] 
	WHERE  fldNameCountry  like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldNameCountry], cast([fldTimeStamp] as int)[fldTimeStamp] 
	FROM   [dbo].[tblCountry] 

	
	COMMIT
GO
