SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblExternalLetterSenderUpdate] 
    @fldID int,
    @fldLetterID bigint = NULL,
    @fldMessageId int = NULL,
   -- @fldAshkhasHoghoghiId int,
  @fldShakhsHoghoghiTitlesId int,
    @fldOrganId int,
    @fldUserID int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblExternalLetterSender]
	SET    [fldLetterID] = @fldLetterID, [fldMessageId] = @fldMessageId, /*[fldAshkhasHoghoghiId] = @fldAshkhasHoghoghiId,*/fldShakhsHoghoghiTitlesId =@fldShakhsHoghoghiTitlesId, [fldDate] = getdate(), [fldOrganId] = @fldOrganId, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
