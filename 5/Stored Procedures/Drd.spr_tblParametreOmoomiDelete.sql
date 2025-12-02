SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreOmoomiDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE [Drd].[tblParametreOmoomi]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId
	DELETE
	FROM   [Drd].[tblParametreOmoomi]
	WHERE  fldId = @fldId

	COMMIT
GO
