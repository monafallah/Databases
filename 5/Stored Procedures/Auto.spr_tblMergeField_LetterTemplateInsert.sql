SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMergeField_LetterTemplateInsert] 
   
    @fldLetterTamplateId int,
    @fldMergeFieldId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(15)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblMergeField_LetterTemplate] 

	INSERT INTO [Auto].[tblMergeField_LetterTemplate] ([fldId], [fldLetterTamplateId], [fldMergeFieldId], [fldUserId], [fldOrganId], [fldDesc], [fldIP], [fldDate])
	SELECT @fldId, @fldLetterTamplateId, @fldMergeFieldId, @fldUserId, @fldOrganId, @fldDesc, @fldIP, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
