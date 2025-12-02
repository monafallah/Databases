SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterAttachmentUpdate] 
    @fldID int,
    @fldLetterId bigint,

    @fldName nvarchar(100),
    @fldContentFileId int,
    @fldUserId int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblLetterAttachment]
	SET    [fldLetterID] = @fldLetterID, [fldName] = @fldName, [fldContentFileID] = @fldContentFileID, [fldDesc] = @fldDesc
	,fldOrganId =@fldOrganId,fldIP=@fldIp
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
