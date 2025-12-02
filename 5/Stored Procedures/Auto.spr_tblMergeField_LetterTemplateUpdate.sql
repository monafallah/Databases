SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMergeField_LetterTemplateUpdate] 
    @fldId int,
    @fldLetterTamplateId int,
    @fldMergeFieldId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(15)
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblMergeField_LetterTemplate]
	SET    [fldLetterTamplateId] = @fldLetterTamplateId, [fldMergeFieldId] = @fldMergeFieldId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldIP] = @fldIP, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
