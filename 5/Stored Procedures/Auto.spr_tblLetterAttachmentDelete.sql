SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterAttachmentDelete] 
    @fldId int,
    @fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Auto].[tblLetterAttachment]
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
