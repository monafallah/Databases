SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFiles_DetailDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE  [Drd].[tblPardakhtFiles_Detail]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId
	DELETE
	FROM   [Drd].[tblPardakhtFiles_Detail]
	WHERE  fldId = @fldId

	COMMIT
GO
