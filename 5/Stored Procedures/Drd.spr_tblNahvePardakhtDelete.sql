SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblNahvePardakhtDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE    [Drd].[tblNahvePardakht]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId
	DELETE
	FROM   [Drd].[tblNahvePardakht]
	WHERE  fldId = @fldId

	COMMIT
GO
