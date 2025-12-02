SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE Str.tblAnbar
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	delete tblAnbar_Tree where fldAnbarId=@fldID
	DELETE
	FROM   [Str].[tblAnbar]
	WHERE  fldId = @fldId

	COMMIT
GO
