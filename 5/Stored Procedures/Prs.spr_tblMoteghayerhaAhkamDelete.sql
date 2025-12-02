SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblMoteghayerhaAhkamDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Prs].[tblMoteghayerhaAhkam]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblMoteghayerhaAhkam]
	WHERE  fldId = @fldId

	COMMIT
GO
