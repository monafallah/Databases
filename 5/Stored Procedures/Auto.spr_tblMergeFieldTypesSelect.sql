SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMergeFieldTypesSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldFaName], [fldEnName], [fldOrganId], [fldDate] ,fldType,fldUserid
	,case when fldtype=1 then N'ورود دستی اطلاعات' else  N'اطلاعات نامه صادره' end as fldTypeName
	FROM   [Auto].[tblMergeFieldTypes] 
	WHERE  fldId=@Value
	order by flddate desc

	if (@FieldName='fldFaName')
		SELECT top(@h) [fldId], [fldFaName], [fldEnName], [fldOrganId], [fldDate] ,fldType,fldUserid
	,case when fldtype=1 then N'ورود دستی اطلاعات' else  N'اطلاعات نامه صادره' end as fldTypeName
	FROM   [Auto].[tblMergeFieldTypes]  
	WHERE  fldFaName like @Value and fldOrganId=@organId
		order by flddate desc

	if (@FieldName='fldEnName')
	SELECT top(@h) [fldId], [fldFaName], [fldEnName], [fldOrganId], [fldDate] ,fldType,fldUserid
	,case when fldtype=1 then N'ورود دستی اطلاعات' else  N'اطلاعات نامه صادره' end as fldTypeName
	FROM   [Auto].[tblMergeFieldTypes] 
	WHERE  fldEnName like @Value and fldOrganId=@organId
		order by flddate desc

	if (@FieldName='fldOrganId')
		SELECT top(@h) [fldId], [fldFaName], [fldEnName], [fldOrganId], [fldDate] ,fldType,fldUserid
	,case when fldtype=1 then N'ورود دستی اطلاعات' else  N'اطلاعات نامه صادره' end as fldTypeName
	FROM   [Auto].[tblMergeFieldTypes] 
	WHERE  fldOrganId like @organId
		order by flddate desc

	if (@FieldName='')
		SELECT top(@h) [fldId], [fldFaName], [fldEnName], [fldOrganId], [fldDate] ,fldType,fldUserid
	,case when fldtype=1 then N'ورود دستی اطلاعات' else  N'اطلاعات نامه صادره' end as fldTypeName
	FROM   [Auto].[tblMergeFieldTypes] 
		order by flddate desc

	COMMIT
GO
