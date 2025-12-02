SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblSignerDelete] 
    @fldID bigint,
    @fldUserID int
AS 
BEGIN TRAN
	DELETE
	FROM   [Auto].[tblSigner]
	
	WHERE  [fldLetterID] = @fldID

IF(@@ERROR<>0)
  ROLLBACK
COMMIT TRAN

GO
