SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarGroupDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE Str.tblAnbarGroup
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldId
	DELETE
	FROM   [Str].[tblAnbarGroup]
	WHERE  fldId = @fldId

	COMMIT
GO
