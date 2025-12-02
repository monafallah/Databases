SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblSubstituteDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE Auto.tblSubstitute
	SET [fldUserID]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldId 
	
	
	
	
	DELETE
	FROM   [Auto].[tblSubstitute]
	WHERE  fldId = @fldId

	COMMIT
GO
