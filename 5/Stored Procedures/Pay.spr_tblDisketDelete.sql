SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblDisketDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Pay].[tblDisket]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblDisket]
	WHERE  fldId = @fldId

	COMMIT
GO
