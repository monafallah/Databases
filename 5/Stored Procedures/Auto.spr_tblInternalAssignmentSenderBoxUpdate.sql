SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblInternalAssignmentSenderBoxUpdate] 
    @fldID int,    
    @fldBoxID int,
    @fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Auto].[tblInternalAssignmentSender]
	SET    [fldBoxID] = @fldBoxID,fldDate=getdate(),fldUserId=@fldUserID
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
