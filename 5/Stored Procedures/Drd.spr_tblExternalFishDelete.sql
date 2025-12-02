SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblExternalFishDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE    [Drd].[tblExternalFish]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblExternalFish]
	WHERE  fldId = @fldId

	COMMIT
GO
