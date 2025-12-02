SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblStateDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE     [Com].[tblState]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Com].[tblState]
	WHERE  fldId = @fldId

	COMMIT
GO
