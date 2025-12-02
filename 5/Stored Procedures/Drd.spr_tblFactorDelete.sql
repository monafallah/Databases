SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblFactorDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Drd].[tblFactor]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblFactor]
	WHERE  fldId = @fldId

	COMMIT
GO
