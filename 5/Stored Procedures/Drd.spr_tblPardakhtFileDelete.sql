SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFileDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE [Drd].[tblPardakhtFile]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId
	DELETE
	FROM   [Drd].[tblPardakhtFile]
	WHERE  fldId = @fldId
GO
