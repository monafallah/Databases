SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCoding_DetailsDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE ACC.tblCoding_Details
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	
	DELETE
	FROM   [ACC].[tblCoding_Details]
	WHERE  fldId = @fldId

	COMMIT
GO
