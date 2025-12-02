SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterDelete] 
    @fldId bigint,
    @fldUserID int
AS 
	BEGIN TRAN
	update  [Auto].[tblLetter]
	set fldUserId=@fldUserID,fldDate=getdate()
	where fldid=@fldId
	if (@@error<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Auto].[tblLetter]

	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK
	end
	COMMIT TRAN
GO
