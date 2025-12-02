SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterAttachmentLetterIDDelete] 
    @fldId bigint,
    @fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Auto].[tblLetterAttachment]
	WHERE  [fldLetterID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
