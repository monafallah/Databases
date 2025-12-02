SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblParameteriItemsFormulDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Pay].[tblParameteriItemsFormul]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblParameteriItemsFormul]
	WHERE  fldId = @fldId

	COMMIT
GO
