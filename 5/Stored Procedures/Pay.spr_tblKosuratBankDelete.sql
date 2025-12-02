SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKosuratBankDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblKosuratBank]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblKosuratBank]
	WHERE  fldId = @fldId

	COMMIT
GO
