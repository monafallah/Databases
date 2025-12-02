SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFishDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE  [Drd].[tblPardakhtFish]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldFishId = @fldId
	DELETE
	FROM   [Drd].[tblPardakhtFish]
	WHERE  fldFishId = @fldId

	COMMIT
GO
