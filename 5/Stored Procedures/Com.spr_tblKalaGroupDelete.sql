SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaGroupDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE com.tblKalaGroup
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	if(@@error<>0)
	rollback
	else
	begin
	
	DELETE
	FROM   [com].[tblKalaGroup]
	WHERE  fldId = @fldId
	if(@@error<>0)
	rollback
	end
	COMMIT
GO
