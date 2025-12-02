SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblAssignmentTypeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE Auto.tblAssignmentType
	SET [fldUserId]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldID
	
	
	
	DELETE
	FROM   [Auto].[tblAssignmentType]
	WHERE  fldId = @fldId

	COMMIT
GO
