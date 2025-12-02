SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblInternalLetterReceiverUpdate] 
    @fldID int,
    @fldLetterId bigint,
	    @fldMessageId int,
    @fldReceiverComisionID int,
    @fldAssignmentStatusID int,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	BEGIN TRAN
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblInternalLetterReceiver]
	SET    [fldLetterID] = @fldLetterID, [fldReceiverComisionID] = @fldReceiverComisionID, [fldAssignmentStatusID] = @fldAssignmentStatusID, [fldDesc] = @fldDesc
,fldMessageId=@fldMessageId,fldOrganId=@fldOrganId,fldIP=@fldIP,fldDate=getdate()
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN
GO
