SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMergeField_LetterTemplateSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,m.fldType
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	WHERE  [tblMergeField_LetterTemplate].fldId=@Value and [tblMergeField_LetterTemplate].fldOrganId=@organId

	if (@FieldName='fldDesc')
		SELECT top(@h) [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,m.fldType
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	WHERE  [tblMergeField_LetterTemplate].fldDesc like @Value  and [tblMergeField_LetterTemplate].fldOrganId=@organId

	if (@FieldName='fldLetterTamplateId')
		SELECT top(@h) [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,m.fldType
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	WHERE  fldLetterTamplateId like @Value  and [tblMergeField_LetterTemplate].fldOrganId=@organId

	if (@FieldName='CheckLetterTamplateId')
		SELECT top(@h) [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,m.fldType
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	WHERE  fldLetterTamplateId like @Value

		if (@FieldName='fldMergeFieldId')
		SELECT top(@h) [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,m.fldType
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	WHERE  fldMergeFieldId like @Value  and [tblMergeField_LetterTemplate].fldOrganId=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,m.fldType
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	WHERE  [tblMergeField_LetterTemplate]. fldOrganId=@organId


	if (@FieldName='')
		SELECT top(@h) [tblMergeField_LetterTemplate].[fldId], [fldLetterTamplateId], [fldMergeFieldId], [tblMergeField_LetterTemplate].[fldUserId], [tblMergeField_LetterTemplate].[fldOrganId], [tblMergeField_LetterTemplate].[fldDesc], [tblMergeField_LetterTemplate].[fldIP], [tblMergeField_LetterTemplate].[fldDate] 
	,m.fldEnName,m.fldFaName,l.fldName as fldTitleLetter,m.fldType
	FROM   [Auto].[tblMergeField_LetterTemplate] 
	inner join [auto].[tblMergeFieldTypes] m on m.fldid=fldMergeFieldId
	inner join [auto].[tblLetterTemplate] l on l.fldid=fldLetterTamplateId
	
	COMMIT
GO
