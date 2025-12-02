SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterArchiveLetterIDDelete] 
    @fldId bigint,
    @fldUserID int
AS 
	BEGIN TRAN
	update [Auto].[tblLetterArchive]
	set fldUserId=@fldUserID,fldDate=getdate()
	WHERE  [fldLetterID] = @fldID
	if (@@error<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Auto].[tblLetterArchive]
	WHERE  [fldLetterID] = @fldID

	IF(@@ERROR<>0) ROLLBACK
	end
	COMMIT TRAN

GO
