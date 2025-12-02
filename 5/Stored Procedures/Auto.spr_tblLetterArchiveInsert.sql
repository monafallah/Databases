SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterArchiveInsert] 
    @fldLetterId bigint,
	@fldMessageId int,
    @fldArchiveID int,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
	
AS 
	DECLARE @fldID bigint
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterArchive]
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	
	INSERT INTO [Auto].[tblLetterArchive] ([fldID], [fldLetterID],fldMessageId, [fldArchiveID], [fldDate], [fldUserID], [fldDesc],fldOrganId,fldIP)
	
	SELECT @fldID, @fldLetterID,@fldMessageId, @fldArchiveID, GETDATE(), @fldUserID, @fldDesc,@fldOrganId,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
