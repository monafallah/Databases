SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblLevelsAccountingTypeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblLevelsAccountingType
	SET fldUserId=@fldUserID,flddate=GETDATE()
	WHERE fldId=@fldId 
	
	DELETE
	FROM   [ACC].[tblLevelsAccountingType]
	WHERE  fldId = @fldId

	COMMIT
GO
