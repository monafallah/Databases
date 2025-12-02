SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblItemNecessaryDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE ACC.tblItemNecessary
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldId
	DELETE
	FROM   [ACC].[tblItemNecessary]
	WHERE  fldId = @fldId

	COMMIT
GO
