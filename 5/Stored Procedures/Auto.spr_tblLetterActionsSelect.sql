SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterActionsSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [tblLetterActions].[fldId], [fldLetterId], [fldTarikhAnjam], [fldTimeAnjam], [fldLetterActionTypeId], [tblLetterActions].[fldUserId]
	, [tblLetterActions].[fldOrganId], [tblLetterActions].[fldDesc],[tblLetterActions]. [fldDate], [tblLetterActions].[fldIP] 
	,fldSubject,[fldTitleActionType]
	FROM   [Auto].[tblLetterActions] 
	inner join auto.tblLetter on fldLetterId=tblLetter.fldid
	inner join auto.tblLetterActionType on tblLetterActionType.fldid=fldLetterActionTypeId
	WHERE  [tblLetterActions].fldId=@Value and [tblLetterActions].fldOrganId=@OrganId

	if (@FieldName='fldLetterId')
	SELECT top(@h) [tblLetterActions].[fldId], [fldLetterId], [fldTarikhAnjam], [fldTimeAnjam], [fldLetterActionTypeId], [tblLetterActions].[fldUserId]
	, [tblLetterActions].[fldOrganId], [tblLetterActions].[fldDesc],[tblLetterActions]. [fldDate], [tblLetterActions].[fldIP] 
	,fldSubject,[fldTitleActionType]
	FROM   [Auto].[tblLetterActions] 
	inner join auto.tblLetter on fldLetterId=tblLetter.fldid
	inner join auto.tblLetterActionType on tblLetterActionType.fldid=fldLetterActionTypeId
	WHERE  [tblLetterActions].fldLetterId=@Value and [tblLetterActions].fldOrganId=@OrganId

		if (@FieldName='fldLetterActionTypeId')
	SELECT top(@h) [tblLetterActions].[fldId], [fldLetterId], [fldTarikhAnjam], [fldTimeAnjam], [fldLetterActionTypeId], [tblLetterActions].[fldUserId]
	, [tblLetterActions].[fldOrganId], [tblLetterActions].[fldDesc],[tblLetterActions]. [fldDate], [tblLetterActions].[fldIP] 
	,fldSubject,[fldTitleActionType]
	FROM   [Auto].[tblLetterActions] 
	inner join auto.tblLetter on fldLetterId=tblLetter.fldid
	inner join auto.tblLetterActionType on tblLetterActionType.fldid=fldLetterActionTypeId
	WHERE  [tblLetterActions].fldLetterActionTypeId=@Value and [tblLetterActions].fldOrganId=@OrganId


	if (@FieldName='fldDesc')
	SELECT top(@h) [tblLetterActions].[fldId], [fldLetterId], [fldTarikhAnjam], [fldTimeAnjam], [fldLetterActionTypeId], [tblLetterActions].[fldUserId]
	, [tblLetterActions].[fldOrganId], [tblLetterActions].[fldDesc],[tblLetterActions]. [fldDate], [tblLetterActions].[fldIP] 
	,fldSubject,[fldTitleActionType]
	FROM   [Auto].[tblLetterActions] 
	inner join auto.tblLetter on fldLetterId=tblLetter.fldid
	inner join auto.tblLetterActionType on tblLetterActionType.fldid=fldLetterActionTypeId
	WHERE  [tblLetterActions].fldDesc like @Value and [tblLetterActions].fldOrganId=@OrganId

	if (@FieldName='')
SELECT top(@h) [tblLetterActions].[fldId], [fldLetterId], [fldTarikhAnjam], [fldTimeAnjam], [fldLetterActionTypeId], [tblLetterActions].[fldUserId]
	, [tblLetterActions].[fldOrganId], [tblLetterActions].[fldDesc],[tblLetterActions]. [fldDate], [tblLetterActions].[fldIP] 
	,fldSubject,[fldTitleActionType]
	FROM   [Auto].[tblLetterActions] 
	inner join auto.tblLetter on fldLetterId=tblLetter.fldid
	inner join auto.tblLetterActionType on tblLetterActionType.fldid=fldLetterActionTypeId
	where  [tblLetterActions].fldOrganId=@OrganId

	
	if (@FieldName='fldOrganId')
SELECT top(@h) [tblLetterActions].[fldId], [fldLetterId], [fldTarikhAnjam], [fldTimeAnjam], [fldLetterActionTypeId], [tblLetterActions].[fldUserId]
	, [tblLetterActions].[fldOrganId], [tblLetterActions].[fldDesc],[tblLetterActions]. [fldDate], [tblLetterActions].[fldIP] 
	,fldSubject,[fldTitleActionType]
	FROM   [Auto].[tblLetterActions] 
	inner join auto.tblLetter on fldLetterId=tblLetter.fldid
	inner join auto.tblLetterActionType on tblLetterActionType.fldid=fldLetterActionTypeId
	where  [tblLetterActions].fldOrganId=@OrganId

	
	COMMIT
GO
