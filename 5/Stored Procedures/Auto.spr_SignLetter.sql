SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_SignLetter](@fldId bigint,@fldSigner int,@fldUserID int)
as
BEGIN TRAN

UPDATE [auto].[tblSigner]
	SET    [fldFirstSigner] = @fldSigner,fldUserId=@fldUserID,fldDate=getdate()
	
	WHERE  [fldID] = @fldID
	
IF(@@ERROR<>0)
 ROLLBACK
COMMIT TRAN
GO
