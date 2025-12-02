SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblInternalAssignmentReceiverBoxUpdate] 
    @fldID int,    
    @fldBoxID INT,
    @fldUserID INT
AS 
	BEGIN TRAN
	UPDATE [Auto].[tblInternalAssignmentReceiver]
	SET    [fldBoxID] = @fldBoxID,fldDate=getdate()
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
