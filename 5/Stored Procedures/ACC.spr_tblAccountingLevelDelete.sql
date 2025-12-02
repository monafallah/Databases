SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblAccountingLevelDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblAccountingLevel
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldId 
	
	
	DELETE
	FROM   [ACC].[tblAccountingLevel]
	WHERE  fldId = @fldId

	COMMIT
GO
