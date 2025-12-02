SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblNumberingFormatDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	
	UPDATE Auto.tblNumberingFormat
	SET [fldUserId]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldID
	
	
	
	DELETE
	FROM   [Auto].[tblNumberingFormat]
	WHERE  fldId = @fldId

	COMMIT
GO
