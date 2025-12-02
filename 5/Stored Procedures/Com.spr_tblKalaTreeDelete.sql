SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaTreeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	
	UPDATE com.tblKalaTree
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	
	
	DELETE
	FROM   com.[tblKalaTree]
	WHERE  fldId = @fldId

	COMMIT
GO
