SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_HeaderDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblCoding_Header
	SET fldUserId=@fldUserID,flddate=GETDATE()
	WHERE fldId=@fldID
	DELETE
	FROM   [ACC].[tblCoding_Header]
	WHERE  fldId = @fldId

	COMMIT

GO
