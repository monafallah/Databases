SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEtelaatEydiDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Pay].[tblEtelaatEydi]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblEtelaatEydi]
	WHERE  fldId = @fldId

	COMMIT
GO
