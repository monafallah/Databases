SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE com.tblKala
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	if (@@error<>0)
	rollback
	else
	begin

	DELETE
	FROM   [com].[tblKala]
	WHERE  fldId = @fldId
	if (@@error<>0)
	rollback
	end
	COMMIT
GO
