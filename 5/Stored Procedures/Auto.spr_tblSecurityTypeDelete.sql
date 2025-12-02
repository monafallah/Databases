SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblSecurityTypeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE Auto.tblSecurityType
	SET [fldUserId]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldID
	
	
	
	DELETE
	FROM   [Auto].[tblSecurityType]
	WHERE  fldId = @fldId

	COMMIT

GO
