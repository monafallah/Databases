SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblCountySelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) tblCounty.[fldId],tblCounty.[fldName], [fldStateId]  ,tblState. fldNameState as NameState
	FROM   [dbo].[tblCounty] inner join tblState 
	on fldStateId=tblState.fldid
	WHERE  tblCounty.fldId=@Value
	order by tblCounty.[fldName]

	if (@FieldName='fldName')
	SELECT top(@h) tblCounty.[fldId],tblCounty.[fldName], [fldStateId]  ,tblState. fldNameState as NameState
	FROM   [dbo].[tblCounty] inner join tblState 
	on fldStateId=tblState.fldid
	WHERE  tblCounty.fldName like @Value
		order by tblCounty.[fldName]

	if (@FieldName='NameState')
	SELECT top(@h) tblCounty.[fldId],tblCounty.[fldName], [fldStateId]  ,tblState. fldNameState as NameState
	FROM   [dbo].[tblCounty] inner join tblState 
	on fldStateId=tblState.fldid
	WHERE  tblState. fldNameState  like @Value
		order by tblCounty.[fldName]

	if (@FieldName='fldStateId')
SELECT top(@h) tblCounty.[fldId],tblCounty.[fldName], [fldStateId]  ,tblState. fldNameState as NameState
	FROM   [dbo].[tblCounty] inner join tblState 
	on fldStateId=tblState.fldid
	WHERE  fldStateId like @Value
		order by tblCounty.[fldName]

	if (@FieldName='')
	SELECT top(@h) tblCounty.[fldId],tblCounty.[fldName], [fldStateId]  ,tblState. fldNameState as NameState
	FROM   [dbo].[tblCounty] inner join tblState 
	on fldStateId=tblState.fldid
		order by tblCounty.[fldName]

	COMMIT
GO
