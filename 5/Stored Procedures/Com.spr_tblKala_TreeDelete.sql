SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKala_TreeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE com.tblKala_Tree
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	DELETE
	FROM   com.[tblKala_Tree]
	WHERE  fldId = @fldId

	COMMIT
GO
