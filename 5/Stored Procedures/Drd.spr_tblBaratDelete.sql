SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblBaratDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE   [Drd].[tblBarat]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblBarat]
	WHERE  fldId = @fldId

	COMMIT
GO
