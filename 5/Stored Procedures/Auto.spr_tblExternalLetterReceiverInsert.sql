SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblExternalLetterReceiverInsert] 
 
    @fldLetterID bigint = NULL,
    @fldMessageId int = NULL,
	@fldHoghoghiTitlesId int,
 
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
	
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblExternalLetterReceiver] 

	INSERT INTO [Auto].[tblExternalLetterReceiver] ([fldID], [fldLetterID], [fldMessageId], [fldAshkhasHoghoghiId], [fldDate], [fldOrganId], [fldUserId], [fldDesc], [fldIP],fldHoghoghiTitlesId)
	SELECT @fldID, @fldLetterID, @fldMessageId, null, getdate(), @fldOrganId, @fldUserId, @fldDesc, @fldIP,@fldHoghoghiTitlesId
	if(@@Error<>0)
        rollback       
	COMMIT
GO
