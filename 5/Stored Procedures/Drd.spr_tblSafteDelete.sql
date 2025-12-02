SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblSafteDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE      [Drd].[tblSafte]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblSafte]
	WHERE  fldId = @fldId

	COMMIT
GO
