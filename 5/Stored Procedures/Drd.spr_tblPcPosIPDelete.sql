SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosIPDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE  [Drd].[tblPcPosIP]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblPcPosIP]
	WHERE  fldId = @fldId

	COMMIT
GO
