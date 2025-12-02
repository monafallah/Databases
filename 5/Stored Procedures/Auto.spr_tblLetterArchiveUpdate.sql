SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterArchiveUpdate] 
    @fldId int,
    @fldLetterId bigint,
	@fldMessageId int,
    @fldArchiveID int,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	BEGIN TRAN
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblLetterArchive]
	SET    [fldLetterID] = @fldLetterID,fldMessageId=@fldMessageId,fldOrganId=@fldOrganId,fldIP=@fldIP, [fldArchiveID] = @fldArchiveID, [fldDesc] = @fldDesc

	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
