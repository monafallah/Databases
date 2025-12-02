SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosParam_DetailDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
			UPDATE  [Drd].[tblPcPosParam_Detail]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblPcPosParam_Detail]
	WHERE  fldPcPosInfoId = @fldId

	COMMIT
GO
