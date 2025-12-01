SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblCitySelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) c.[fldId], [fldNameCity], [fldStateId],cast( c.[fldTimeStamp] as int)[fldTimeStamp]
	,s.fldNameState
	FROM   [dbo].[tblCity] c
	inner join tblstate s on s.fldid=c.fldStateid
	WHERE  c.fldId=@Value


	if (@FieldName='fldStateId')
	SELECT top(@h) c.[fldId], [fldNameCity], [fldStateId],cast( c.[fldTimeStamp] as int)[fldTimeStamp]
	,s.fldNameState
	FROM   [dbo].[tblCity] c
	inner join tblstate s on s.fldid=c.fldStateid
	WHERE  c.fldStateId=@Value

	if (@FieldName='fldNameCity')
	SELECT top(@h) c.[fldId], [fldNameCity], [fldStateId],cast( c.[fldTimeStamp] as int)[fldTimeStamp]
	,s.fldNameState
	FROM   [dbo].[tblCity] c
	inner join tblstate s on s.fldid=c.fldStateid
	WHERE  fldNameCity=@Value

	if (@FieldName='')
	SELECT top(@h) c.[fldId], [fldNameCity], [fldStateId],cast( c.[fldTimeStamp] as int)[fldTimeStamp]
	,s.fldNameState
	FROM   [dbo].[tblCity] c
	inner join tblstate s on s.fldid=c.fldStateid
	
	COMMIT
GO
