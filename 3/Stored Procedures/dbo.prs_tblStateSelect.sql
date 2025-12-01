SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblStateSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),

@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) s.[fldId], [fldNameState], [fldCountryId], cast(s.[fldTimeStamp] as int)[fldTimeStamp],
	fldNameCountry
	FROM   [dbo].[tblState] s inner join tblcountry c
	on c.fldid=[fldCountryId]
	WHERE  s.fldId=@Value

	if (@FieldName='[fldNameState]')
	SELECT top(@h) s.[fldId], [fldNameState], [fldCountryId], cast(s.[fldTimeStamp] as int)[fldTimeStamp],
	fldNameCountry
	FROM   [dbo].[tblState] s inner join tblcountry c
	on c.fldid=[fldCountryId]
	WHERE  [fldNameState]=@Value

	if (@FieldName='')
	SELECT top(@h) s.[fldId], [fldNameState], [fldCountryId], cast(s.[fldTimeStamp] as int)[fldTimeStamp],
	fldNameCountry
	FROM   [dbo].[tblState] s inner join tblcountry c
	on c.fldid=[fldCountryId]

	
	COMMIT
GO
