SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblAccountingTypeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblAccountingType
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	
	DELETE
	FROM   [ACC].[tblAccountingType]
	WHERE  fldId = @fldId

	COMMIT
GO
