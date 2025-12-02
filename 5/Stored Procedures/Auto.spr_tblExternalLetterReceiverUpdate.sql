SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblExternalLetterReceiverUpdate] 
    @fldID int,
    @fldLetterID bigint = NULL,
    @fldMessageId int = NULL,
    --@fldAshkhasHoghoghiId int,
	@fldHoghoghiTitlesId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblExternalLetterReceiver]
	SET    [fldLetterID] = @fldLetterID, [fldMessageId] = @fldMessageId, fldHoghoghiTitlesId =@fldHoghoghiTitlesId ,/*[fldAshkhasHoghoghiId] = @fldAshkhasHoghoghiId,*/ [fldDate] = getdate(), [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
