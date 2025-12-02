SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblletterTemplateSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldName], [fldIsBackGround], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	,case when fldIsBackGround=1 then N'دارد' else N'ندارد' end as fldBackGroundName ,
	mergefield.name as fldNameMergeField,mergefieldId.FieldId as fldIdMergeField,mergefieldEn.fldEnName as fldEnNameMergeField
	,fldFormat,fldLetterFileId
	FROM   [Auto].[tblletterTemplate] 
	outer apply (select   (select tblMergeFieldTypes.fldFaName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) name)mergefield
	outer apply (select   (select cast(tblMergeFieldTypes.fldid as varchar(20))+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) FieldId)mergefieldId
	outer apply (select   (select tblMergeFieldTypes.fldEnName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) fldEnName)mergefieldEn
	WHERE  fldId=@Value and fldOrganId=@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldIsBackGround], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	,case when fldIsBackGround=1 then N'دارد' else N'ندارد' end as fldBackGroundName ,
	mergefield.name as fldNameMergeField,mergefieldId.FieldId as fldIdMergeField,mergefieldEn.fldEnName as fldEnNameMergeField
	,fldFormat,fldLetterFileId

	FROM   [Auto].[tblletterTemplate] 
	outer apply (select   (select tblMergeFieldTypes.fldFaName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) name)mergefield
	outer apply (select   (select cast(tblMergeFieldTypes.fldid as varchar(20))+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) FieldId)mergefieldId
		 outer apply (select   (select tblMergeFieldTypes.fldEnName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) fldEnName)mergefieldEn
	WHERE  fldDesc like @Value and fldOrganId=@organId

	if (@FieldName='fldName')
	SELECT top(@h) [fldId], [fldName], [fldIsBackGround], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	,case when fldIsBackGround=1 then N'دارد' else N'ندارد' end as fldBackGroundName ,
	mergefield.name as fldNameMergeField,mergefieldId.FieldId as fldIdMergeField,mergefieldEn.fldEnName as fldEnNameMergeField
	,fldFormat,fldLetterFileId
	FROM   [Auto].[tblletterTemplate] 
	outer apply (select   (select tblMergeFieldTypes.fldFaName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) name)mergefield
	outer apply (select   (select cast(tblMergeFieldTypes.fldid as varchar(20))+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) FieldId)mergefieldId
		 outer apply (select   (select tblMergeFieldTypes.fldEnName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) fldEnName)mergefieldEn
	WHERE  fldName like @Value and fldOrganId=@organId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldName], [fldIsBackGround], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	,case when fldIsBackGround=1 then N'دارد' else N'ندارد' end as fldBackGroundName ,
	mergefield.name as fldNameMergeField,mergefieldId.FieldId as fldIdMergeField,mergefieldEn.fldEnName as fldEnNameMergeField
	,fldFormat,fldLetterFileId
	FROM   [Auto].[tblletterTemplate] 
	outer apply (select   (select tblMergeFieldTypes.fldFaName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) name)mergefield
	outer apply (select   (select cast(tblMergeFieldTypes.fldid as varchar(20))+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) FieldId)mergefieldId
		 outer apply (select   (select tblMergeFieldTypes.fldEnName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) fldEnName)mergefieldEn
	where  fldOrganId=@organId


	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldName], [fldIsBackGround], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	,case when fldIsBackGround=1 then N'دارد' else N'ندارد' end as fldBackGroundName ,
	mergefield.name as fldNameMergeField,mergefieldId.FieldId as fldIdMergeField,mergefieldEn.fldEnName as fldEnNameMergeField
	,fldFormat,fldLetterFileId
	FROM   [Auto].[tblletterTemplate] 
	outer apply (select   (select tblMergeFieldTypes.fldFaName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) name)mergefield
	outer apply (select   (select cast(tblMergeFieldTypes.fldid as varchar(20))+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) FieldId)mergefieldId
		 outer apply (select   (select tblMergeFieldTypes.fldEnName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) fldEnName)mergefieldEn
	where  fldOrganId=@organId

	
	if (@FieldName='fldIdMergeField')
	SELECT top(@h)* from (select  [fldId], [fldName], [fldIsBackGround], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	,case when fldIsBackGround=1 then N'دارد' else N'ندارد' end as fldBackGroundName ,
	mergefield.name as fldNameMergeField,mergefieldId.FieldId as fldIdMergeField,mergefieldEn.fldEnName as fldEnNameMergeField
	,fldFormat,fldLetterFileId
	FROM   [Auto].[tblletterTemplate] 
	outer apply (select   (select tblMergeFieldTypes.fldFaName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) name)mergefield
	outer apply (select   (select cast(tblMergeFieldTypes.fldid as varchar(20))+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) FieldId)mergefieldId
		 outer apply (select   (select tblMergeFieldTypes.fldEnName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) fldEnName)mergefieldEn)t
	WHERE  fldIdMergeField like @Value and fldOrganId=@organId

	if (@FieldName='fldNameMergeField')
	SELECT top(@h)* from (select  [fldId], [fldName], [fldIsBackGround], [fldFileId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP] 
	,case when fldIsBackGround=1 then N'دارد' else N'ندارد' end as fldBackGroundName ,
	mergefield.name as fldNameMergeField,mergefieldId.FieldId as fldIdMergeField,mergefieldEn.fldEnName as fldEnNameMergeField
	,fldFormat,fldLetterFileId
	FROM   [Auto].[tblletterTemplate] 
	outer apply (select   (select tblMergeFieldTypes.fldFaName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) name)mergefield
	outer apply (select   (select cast(tblMergeFieldTypes.fldid as varchar(20))+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) FieldId)mergefieldId
		 outer apply (select   (select tblMergeFieldTypes.fldEnName+',' from [auto].tblMergeField_LetterTemplate
	inner join [auto].tblMergeFieldTypes on fldMergeFieldId=tblMergeFieldTypes.fldid
		 where fldLetterTamplateId=[tblletterTemplate].fldid for xml path('')) fldEnName)mergefieldEn)t
	WHERE  fldNameMergeField like @Value and fldOrganId=@organId


	COMMIT
GO
