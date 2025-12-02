SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebatEzafeKari_TatilKariDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Pay].[tblMohasebatEzafeKari_TatilKari]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblMohasebatEzafeKari_TatilKari]
	WHERE  fldId = @fldId

	COMMIT
GO
