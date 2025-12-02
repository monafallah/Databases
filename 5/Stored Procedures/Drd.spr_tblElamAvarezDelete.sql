SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblElamAvarezDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE    [Drd].[tblElamAvarez]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblElamAvarez]
	WHERE  fldId = @fldId

	COMMIT
GO
