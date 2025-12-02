SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblInternalLetterReceiverDelete] 
    @fldId bigint,
    @fldUserID int
AS 
	BEGIN TRAN
	update [Auto].[tblInternalLetterReceiver]
	set fldUserId=@fldUserID,fldDate=getdate()
	where [fldLetterID]=@fldid
	if (@@error<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Auto].[tblInternalLetterReceiver]
	
	WHERE  [fldLetterID] = @fldID

	IF(@@ERROR<>0) ROLLBACK
end
	COMMIT TRAN

GO
