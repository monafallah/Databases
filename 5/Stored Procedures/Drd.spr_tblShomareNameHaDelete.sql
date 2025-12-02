SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareNameHaDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE    [Drd].[tblShomareNameHa]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblShomareNameHa]
	WHERE  fldId = @fldId

	COMMIT
GO
