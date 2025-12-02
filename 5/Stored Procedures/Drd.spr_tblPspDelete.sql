SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPspDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE  [Drd].[tblPsp]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblPsp]
	WHERE  fldId = @fldId

	COMMIT
GO
