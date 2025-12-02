SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCenterCostDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblCenterCost
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldId 
	DELETE
	FROM   [ACC].[tblCenterCost]
	WHERE  fldId = @fldId

	COMMIT
GO
