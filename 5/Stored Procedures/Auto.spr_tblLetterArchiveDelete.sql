SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterArchiveDelete] 
    @fldId int,
    @fldUserID int
AS 
	BEGIN TRAN
	update Auto.[tblLetterArchive]
	set fldUserId=@fldUserId,fldDate=Getdate()
	where fldid=@fldId
	if (@@error<>0)
	rollback
	else
	begin
		DELETE
	FROM   [dbo].[tblLetterArchive]
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK
	end
	COMMIT TRAN

GO
