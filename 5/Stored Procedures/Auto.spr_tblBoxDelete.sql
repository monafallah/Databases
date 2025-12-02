SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblBoxDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE Auto.tblBox
	SET [fldUserId]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldID
	
	
	
	DELETE
	FROM   [Auto].[tblBox]
	WHERE  fldId = @fldId

	COMMIT

GO
