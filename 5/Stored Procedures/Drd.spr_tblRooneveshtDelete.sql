SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblRooneveshtDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE    [Drd].[tblRoonevesht]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblRoonevesht]
	WHERE  fldId = @fldId

	COMMIT
GO
