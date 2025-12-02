SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblInternalLetterReceiverInsert] 
    @fldLetterId bigint,
	  @fldMessageId int,
    @fldReceiverComisionID int,
    @fldAssignmentStatusID int,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	DECLARE @fldID bigint
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblInternalLetterReceiver]
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	
	INSERT INTO [Auto].[tblInternalLetterReceiver] ([fldID], [fldLetterID],fldMessageId, [fldReceiverComisionID], [fldAssignmentStatusID], [fldDate], [fldUserID], [fldDesc],fldOrganId ,fldIP)

	SELECT @fldID, @fldLetterID,@fldMessageId, @fldReceiverComisionID, @fldAssignmentStatusID, GETDATE(), @fldUserID, @fldDesc,@fldOrganId ,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
