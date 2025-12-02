SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPSPModel_ShomareHesabDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Drd].[tblPSPModel_ShomareHesab]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldPSPModelId = @fldId
	DELETE
	FROM   [Drd].[tblPSPModel_ShomareHesab]
	WHERE  fldPSPModelId = @fldId

	COMMIT
GO
