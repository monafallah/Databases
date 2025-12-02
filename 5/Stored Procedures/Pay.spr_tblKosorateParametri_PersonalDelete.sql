SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosorateParametri_PersonalDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblKosorateParametri_Personal]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	
	DELETE
	FROM   [Pay].[tblKosorateParametri_Personal]
	WHERE  fldId = @fldId

	COMMIT
GO
