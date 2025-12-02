SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMokatebatDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE       [Drd].[tblMokatebat]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId

	DELETE
	FROM   [Drd].[tblMokatebat]
	WHERE  fldId = @fldId

	COMMIT
GO
