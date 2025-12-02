SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreOmoomi_ValueDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE [Drd].[tblParametreOmoomi_Value]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldId = @fldId
	DELETE
	FROM   [Drd].[tblParametreOmoomi_Value]
	WHERE  fldId = @fldId

	COMMIT
GO
