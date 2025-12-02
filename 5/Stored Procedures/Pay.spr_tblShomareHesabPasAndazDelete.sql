SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblShomareHesabPasAndazDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblShomareHesabPasAndaz]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblShomareHesabPasAndaz]
	WHERE  fldId = @fldId

	COMMIT
GO
