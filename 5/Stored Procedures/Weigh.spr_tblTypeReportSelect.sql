SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblTypeReportSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@Value2 nvarchar(50),
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldType], [fldOrganId], [fldBaskoolId], [fldDate], [fldUserId], [fldIP] 
	,case when fldType=1 then N'A4'when fldType=2 then N'A5' end as fldTypeName
	FROM   [Weigh].[tblTypeReport] 
	WHERE  fldId=@Value

	if (@FieldName='fldOrganId_BaskoolId')
	SELECT top(@h) [fldId], [fldType], [fldOrganId], [fldBaskoolId], [fldDate], [fldUserId], [fldIP] 
	,case when fldType=1 then N'A4'when fldType=2 then N'A5' end as fldTypeName
	FROM   [Weigh].[tblTypeReport] 
	WHERE  fldOrganId like @Value and fldBaskoolId=@Value2

	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldType], [fldOrganId], [fldBaskoolId], [fldDate], [fldUserId], [fldIP] 
	,case when fldType=1 then N'A4'when fldType=2 then N'A5' end as fldTypeName
	FROM   [Weigh].[tblTypeReport] 
	WHERE  fldOrganId like @Value

	if (@FieldName='fldBaskoolId')
	SELECT top(@h) [fldId], [fldType], [fldOrganId], [fldBaskoolId], [fldDate], [fldUserId], [fldIP] 
,case when fldType=1 then N'A4'when fldType=2 then N'A5' end as fldTypeName
	FROM   [Weigh].[tblTypeReport] 
	WHERE  fldBaskoolId like @Value

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldType], [fldOrganId], [fldBaskoolId], [fldDate], [fldUserId], [fldIP] 
	,case when fldType=1 then N'A4'when fldType=2 then N'A5' end as fldTypeName
	FROM   [Weigh].[tblTypeReport] 

	
	COMMIT
GO
