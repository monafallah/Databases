SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblTahodatSanavatiDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	update [BUD].[tblTahodatSanavati] set [fldUserId] = @fldUserId,  [fldDate] = getdate()
	WHERE  fldId = @fldId
	DELETE
	FROM   [BUD].[tblTahodatSanavati]
	WHERE  fldId = @fldId

	COMMIT
GO
