SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTree_CenterCostDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblTree_CenterCost
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	
	DELETE
	FROM   [ACC].[tblTree_CenterCost]
	WHERE  fldId = @fldId

	COMMIT
GO
