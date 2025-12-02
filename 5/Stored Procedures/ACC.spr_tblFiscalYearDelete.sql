SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [ACC].[spr_tblFiscalYearDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblFiscalYear
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldId 
	DELETE
	FROM   [ACC].[tblFiscalYear]
	WHERE  fldId = @fldId

	COMMIT
GO
