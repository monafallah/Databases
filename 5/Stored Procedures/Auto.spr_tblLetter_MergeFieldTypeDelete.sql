SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetter_MergeFieldTypeDelete] 
    @fldLetterId bigint,
    @fldUserID int
AS 
	BEGIN TRAN
	UPDATE    [auto].[tblLetter_MergeFieldType]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  [fldLetterId]=@fldLetterId
	if(@@Error<>0)
        rollback 
	else
	begin  

	DELETE
	FROM   [auto].[tblLetter_MergeFieldType]
	
	WHERE  [fldLetterId] = @fldLetterId

	IF(@@ERROR<>0) ROLLBACK
	end
	COMMIT TRAN

GO
