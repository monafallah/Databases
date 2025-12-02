SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTreeCenterCostDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblTreeCenterCost
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	
	
	DELETE
	FROM   [ACC].[tblTreeCenterCost]
	WHERE  fldId = @fldId

	COMMIT
GO
