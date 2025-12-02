SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblGroupCenterCostDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblGroupCenterCost
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	DELETE
	FROM   [ACC].[tblGroupCenterCost]
	WHERE  fldId = @fldId

	COMMIT
GO
