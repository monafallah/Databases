SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarTreeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE Str.tblAnbarTree
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	DELETE
	FROM   [Str].[tblAnbarTree]
	WHERE  fldId = @fldId

	COMMIT
GO
