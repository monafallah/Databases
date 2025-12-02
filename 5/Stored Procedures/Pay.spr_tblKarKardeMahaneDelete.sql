SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardeMahaneDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblKarKardeMahane]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId

	DELETE
	FROM   [Pay].[tblKarKardHokm]
	WHERE  fldKarkardId = @fldId

	DELETE
	FROM   [Pay].[tblKarKardeMahane]
	WHERE  fldId = @fldId

	COMMIT
GO
