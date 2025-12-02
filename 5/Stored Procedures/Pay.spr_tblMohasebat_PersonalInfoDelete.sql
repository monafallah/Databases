SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_PersonalInfoDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Pay].[tblMohasebat_PersonalInfo]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblMohasebat_PersonalInfo]
	WHERE  fldId = @fldId

	COMMIT
GO
