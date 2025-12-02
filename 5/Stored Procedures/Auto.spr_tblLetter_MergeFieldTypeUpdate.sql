SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetter_MergeFieldTypeUpdate] 
    @fldId int,
    @fldLetterId bigint,
    @fldMergeTypeId int,
	@fldValue nvarchar(200),
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(200)
AS 
	 
	
	BEGIN TRAN

	UPDATE [Auto].[tblLetter_MergeFieldType]
	SET    [fldLetterId] = @fldLetterId, [fldMergeTypeId] = @fldMergeTypeId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
