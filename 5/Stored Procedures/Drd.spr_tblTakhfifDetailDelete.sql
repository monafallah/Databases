SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTakhfifDetailDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Drd].[tblTakhfifDetail]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE   fldTakhfifId = @fldId
	DELETE
	FROM   [Drd].[tblTakhfifDetail]
	WHERE  fldTakhfifId = @fldId

	COMMIT
GO
